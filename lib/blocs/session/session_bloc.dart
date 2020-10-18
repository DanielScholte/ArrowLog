import 'dart:async';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/repositories/session.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository sessionRepository;

  SessionBloc({
    @required this.sessionRepository,
  }): super(LoadedSessionState(
    sessions: sessionRepository.getSessions(),
    disableInput: false
  ));

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    if (event is StartNewSessionEvent) {
      yield LoadingSessionsState();
      await sessionRepository.saveNewSession(event.session);
      yield getSessionState();
    } else if (event is SessionSetScoresEvent) {
      yield getSessionState(disableInput: true);
      await sessionRepository.setScores(event.sessionId, event.scoreIds, event.saveChanges);
      yield getSessionState();
    } else if (event is DeleteSessionEvent) {
      yield LoadingSessionsState();
      await sessionRepository.deleteSession(event.sessionId);
      yield getSessionState();
    } else if (event is RefreshSessionsEvent) {
      yield LoadingSessionsState();
      await sessionRepository.loadSessions();
      sessionRepository.loadSessionsDetails();
      yield getSessionState();
    }
  }

  LoadedSessionState getSessionState({bool disableInput = false}) {
    return LoadedSessionState(
      sessions: sessionRepository.getSessions(),
      disableInput: disableInput
    );
  }
}
