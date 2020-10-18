import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:arrow_log/services/match_type.dart';
import 'package:arrow_log/services/target_face.dart';

class MatchTypeRepository {
  final MatchTypeService matchTypeService;
  final TargetFaceService targetFaceService;

  MatchTypeRepository({
    this.matchTypeService,
    this.targetFaceService,
  });

  List<TargetFace> getTargetFaces() => targetFaceService.getTargetFaces();

  List<MatchType> getMatchTypes() {
    List<MatchType> matchTypes = matchTypeService.getAvailableMatchTypes();
    List<TargetFace> targetFaces = targetFaceService.getTargetFaces();

    matchTypes.forEach((m) => m.targetFace = targetFaces.firstWhere((t) => t.id == m.targetFaceId, orElse: () => null));

    return matchTypes;
  }

  Future<void> addMatchType(MatchType matchType) => matchTypeService.saveType(matchType);
  Future<void> deleteMatchType(MatchType type) => matchTypeService.deleteType(type);
}