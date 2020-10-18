import 'dart:async';

import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:arrow_log/repositories/match_type.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'matchtype_event.dart';
part 'matchtype_state.dart';

class MatchtypeBloc extends Bloc<MatchtypeEvent, MatchtypeState> {
  final MatchTypeRepository matchTypeRepository;

  MatchtypeBloc({
    @required this.matchTypeRepository,
  }): super(LoadingMatchTypeState()) {
    add(LoadMatchTypesEvent());
  }

  @override
  Stream<MatchtypeState> mapEventToState(
    MatchtypeEvent event,
  ) async* {
    yield LoadingMatchTypeState();

    if (event is AddMatchTypeEvent) {
      await matchTypeRepository.addMatchType(event.matchType);
    } else if (event is DeleteMatchTypeEvent) {
      await matchTypeRepository.deleteMatchType(event.matchType);
    }

    yield MatchTypesState(
      matchTypes: matchTypeRepository.getMatchTypes(),
      targetFaces: matchTypeRepository.getTargetFaces(),
    );
  }
}
