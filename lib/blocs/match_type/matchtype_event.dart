part of 'matchtype_bloc.dart';

@immutable
abstract class MatchtypeEvent {}

class LoadMatchTypesEvent extends MatchtypeEvent {}

class AddMatchTypeEvent extends MatchtypeEvent {
  final MatchType matchType;

  AddMatchTypeEvent({
    @required this.matchType,
  });
}

class DeleteMatchTypeEvent extends MatchtypeEvent {
  final MatchType matchType;

  DeleteMatchTypeEvent({
    @required this.matchType,
  });
}

class RenameMatchTypeEvent extends MatchtypeEvent {
  final int matchTypeId;
  final String name;

  RenameMatchTypeEvent({
    @required this.matchTypeId,
    @required this.name,
  });
}