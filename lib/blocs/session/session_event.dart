part of 'session_bloc.dart';

@immutable
abstract class SessionEvent {}

class RefreshHistoryEvent extends SessionEvent {}

class DeleteSessionEvent extends SessionEvent {
  final int sessionId;

  DeleteSessionEvent({
    @required this.sessionId
  });
}

class StartNewSessionEvent extends SessionEvent {
  final Session session;

  StartNewSessionEvent({
    @required this.session
  });
}

class SessionSetScoresEvent extends SessionEvent {
  final int sessionId;
  final List<int> scoreIds;
  final bool saveChanges;

  SessionSetScoresEvent({
    @required this.sessionId,
    @required this.scoreIds,
    this.saveChanges = true
  });
}

class RefreshSessionsEvent extends SessionEvent {}

class RenameSessionEvent extends SessionEvent {
  final int sessionId;
  final String name;

  RenameSessionEvent({
    @required this.sessionId,
    @required this.name,
  });
}