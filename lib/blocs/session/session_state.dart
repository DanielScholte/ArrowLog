part of 'session_bloc.dart';

@immutable
abstract class SessionState {}

class LoadingSessionsState extends SessionState {}

class LoadedSessionState extends SessionState {
  final List<Session> sessions;
  final bool disableInput;

  LoadedSessionState({
    @required this.sessions,
    @required this.disableInput
  });
}
