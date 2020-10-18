import 'package:arrow_log/repositories/match_type.dart';
import 'package:arrow_log/repositories/session.dart';
import 'package:arrow_log/services/match_type.dart';
import 'package:arrow_log/services/session.dart';
import 'package:arrow_log/services/target_face.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/match_type/matchtype_bloc.dart';
import 'blocs/session/session_bloc.dart';

class ArrowLogFactory {
  SessionService sessionService;
  MatchTypeService matchTypeService;
  TargetFaceService targetFaceService;

  SessionRepository sessionRepository;

  Future<void> initializeServices() async {
    sessionService = SessionService();
    await sessionService.loadSessions();
    
    matchTypeService = MatchTypeService();
    await matchTypeService.loadMatchTypes();

    targetFaceService = TargetFaceService();

    sessionRepository = SessionRepository(
      matchTypeService: matchTypeService,
      sessionService: sessionService,
      targetFaceService: targetFaceService,
    );
    sessionRepository.loadSessionsDetails();
  }

  Widget initializeRepositories({Widget child}) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<MatchTypeRepository>(
          create: (BuildContext context) => MatchTypeRepository(
            matchTypeService: matchTypeService,
            targetFaceService: targetFaceService,
          ),
        ),
        RepositoryProvider<SessionRepository>(
          create: (BuildContext context) => sessionRepository,
        ),
      ],
    );
  }

  Widget initializeBlocs({Widget child}) {
    return MultiBlocProvider(
      child: child,
      providers: [
        BlocProvider<SessionBloc>(
          create: (BuildContext context) => SessionBloc(
            sessionRepository: RepositoryProvider.of<SessionRepository>(context),
          ),
        ),
        BlocProvider<MatchtypeBloc>(
          create: (BuildContext context) => MatchtypeBloc(
            matchTypeRepository: RepositoryProvider.of<MatchTypeRepository>(context),
          ),
        )
      ],
    );
  }
}