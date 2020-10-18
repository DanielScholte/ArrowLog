import 'dart:math';

import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/services/match_type.dart';
import 'package:arrow_log/services/session.dart';
import 'package:arrow_log/services/target_face.dart';

class SessionRepository {
  final MatchTypeService matchTypeService;
  final TargetFaceService targetFaceService;
  final SessionService sessionService;

  SessionRepository({
    this.matchTypeService,
    this.targetFaceService,
    this.sessionService,
  });
  
  Session _getSessionById(int sessionId) => sessionService.getSessions().firstWhere((s) => s.id == sessionId, orElse: () => null);

  List<Session> getSessions() => sessionService.getSessions();

  Future<void> saveNewSession(Session session) async {
    MatchType matchType = matchTypeService.getMatchType(session.matchTypeId);
    session.scoreIds = List.filled(matchType.arrowsPerRound * matchType.rounds, null, growable: true);
    await sessionService.saveSession(session);
    await sessionService.loadSessions();
    loadSessionsDetails();
  }

  Future<void> setScores(int sessionId, List<int> scoreIds, bool saveChanges) async {
    Session session = _getSessionById(sessionId);

    if (session == null) return;

    session.scoreIds = scoreIds;
    if (saveChanges) {
      await sessionService.updateSession(session);
    }
    _loadSessionDetails(session);
  }

  Future<void> deleteSession(int id) async {
    await sessionService.deleteSession(id);
    await sessionService.loadSessions();
    loadSessionsDetails();
  }

  Future<void> loadSessions() => sessionService.loadSessions();

  void loadSessionsDetails() {
    sessionService.getSessions()
      .forEach((s) => _loadSessionDetails(s));
  }

  void _loadSessionDetails(Session session) {
    session.matchType = _getMatchType(session.matchTypeId);
    
    if (session.matchType == null) {
      return null;
    }

    session.state = SessionDataState();
    session.state.status = 
      session.scoreIds.any((s) => s == null)
      && session.when.difference(DateTime.now()).inHours < 24
      ? SessionStatus.IN_PROGRESS : SessionStatus.FINISHED;

    int maxScore = session.matchType.targetFace.scores.map((s) => s.value).reduce(max);
    session.state.maxScore = (session.matchType.rounds * session.matchType.arrowsPerRound) * maxScore;

    session.state.scores = session.scoreIds.map((s) => s != null ? session.matchType.targetFace.scores.firstWhere((f) => f.id == s) : null).toList();

    List<int> scores = session.state.scores.map((s) => s != null ? s.value : null).toList();
    session.state.currentScrore = scores.where((s) => s != null).fold(0, (p, c) => p + c);

    session.state.subTotalScoreSegments = Iterable<int>
      .generate(session.matchType.rounds)
      .map<int>((round) =>
        scores.getRange(round * session.matchType.arrowsPerRound, (round * session.matchType.arrowsPerRound) + session.matchType.arrowsPerRound)
          .where((s) => s != null)
          .fold(0, (p, c) => p + c)
      )
      .toList();
    
    session.state.totalScoreSegments = Iterable<int>
      .generate(session.matchType.rounds)
      .map<int>((round) =>
        session.state.subTotalScoreSegments
          .take(round + 1)
          .fold(0, (p, c) => p + c)
      )
      .toList();
}

  MatchType _getMatchType(int id) {
    MatchType matchType = matchTypeService.getMatchType(id);

    if (matchType == null) {
      return null;
    }

    matchType.targetFace = targetFaceService.getTargetFace(matchType.targetFaceId);
    return matchType;
  }
}