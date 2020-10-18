import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:intl/intl.dart';

class Session {
  int id;
  String name;
  DateTime when;
  MatchType matchType;
  int matchTypeId;
  List<int> scoreIds;
  int completed;

  SessionDataState state;

  Session({
    this.name,
    this.when,
    this.matchType,
    this.matchTypeId,
    this.scoreIds,
    this.completed = 0,
  });

  Session.fromDb(Map<String, dynamic> item) {
    id =  item['id'];
    name = item['name'];
    when = DateFormat('yyyy-MM-dd HH:mm:ss').parse(item['date']);
    matchTypeId = item['match_type_id'];
    scoreIds = item['scores'].split(',').map<int>((s) => int.tryParse(s)).toList();
    completed = item['completed'];
  }

  Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(this.when);
    data['match_type_id'] = this.matchTypeId;
    data['scores'] = this.scoreIds.join(',');
    data['completed'] = this.completed;
    
    return data;
  }
}

class SessionDataState {
  SessionStatus status;
  int maxScore;
  int currentScrore;
  List<int> subTotalScoreSegments;
  List<int> totalScoreSegments;
  List<TargetFaceScore> scores;

  SessionDataState({
    this.status,
    this.maxScore,
    this.currentScrore,
    this.subTotalScoreSegments,
    this.scores
  });
}

enum SessionStatus {
  IN_PROGRESS,
  FINISHED
}