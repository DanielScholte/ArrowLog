part of 'matchtype_bloc.dart';

@immutable
abstract class MatchtypeState {}

class LoadingMatchTypeState extends MatchtypeState {}

class MatchTypesState extends MatchtypeState {
  final List<MatchType> matchTypes;
  final List<TargetFace> targetFaces;

  MatchTypesState({
    @required this.matchTypes,
    @required this.targetFaces
  });
}