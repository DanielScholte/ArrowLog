import 'package:arrow_log/models/match_type/target_face.dart';

class MatchType {
  int id;
  String name;
  int distance;
  int arrowsPerRound;
  int rounds;
  int targetFaceId;
  TargetFace targetFace;
  int deleted;

  MatchType({
    this.id,
    this.name,
    this.distance,
    this.arrowsPerRound,
    this.rounds,
    this.targetFaceId,
    this.targetFace,
    this.deleted = 0,
  });

  MatchType.fromDb(Map<String, dynamic> item) {
    id =  item['id'];
    name = item['name'];
    distance = item['distance'];
    arrowsPerRound = item['arrows'];
    rounds = item['rounds'];
    targetFaceId = item['target_face_id'];
    deleted = item['deleted'];
  }

  Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['arrows'] = this.arrowsPerRound;
    data['rounds'] = this.rounds;
    data['target_face_id'] = this.targetFaceId;
    data['deleted'] = this.deleted;
    
    return data;
  }
}