import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:flutter/material.dart';

class TargetFaceService {
  TargetFaceService() {
    _targetFaces.forEach((f) => f.scores.sort((a, b) => b.id - a.id));
  }

  List<TargetFace> getTargetFaces() {
    return this._targetFaces;
  }

  TargetFace getTargetFace(int id) {
    return this._targetFaces.firstWhere((t) => t.id == id, orElse: () => null);
  }

  List<TargetFace> _targetFaces = [
    TargetFace(
      id: 0,
      imageUrl: 'assets/target_faces/normal.png',
      name: 'Generic',
      scores: [
        TargetFaceScore(
          id: 0,
          value: 0,
          label: 'M',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 1,
          value: 1,
          label: '1',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 2,
          value: 2,
          label: '2',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 3,
          value: 3,
          label: '3',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 4,
          value: 4,
          label: '4',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 5,
          value: 5,
          label: '5',
          color: Colors.blue,
        ),
        TargetFaceScore(
          id: 6,
          value: 6,
          label: '6',
          color: Colors.blue,
        ),
        TargetFaceScore(
          id: 7,
          value: 7,
          label: '7',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 8,
          value: 8,
          label: '8',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 9,
          value: 9,
          label: '9',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 10,
          value: 10,
          label: '10',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 11,
          value: 10,
          label: 'X',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ]
    ),
    TargetFace(
      id: 1,
      imageUrl: 'assets/target_faces/compound.png',
      name: 'Compound',
      scores: [
        TargetFaceScore(
          id: 0,
          value: 0,
          label: 'M',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 5,
          value: 5,
          label: '5',
          color: Colors.blue,
        ),
        TargetFaceScore(
          id: 6,
          value: 6,
          label: '6',
          color: Colors.blue,
        ),
        TargetFaceScore(
          id: 7,
          value: 7,
          label: '7',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 8,
          value: 8,
          label: '8',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 9,
          value: 9,
          label: '9',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 10,
          value: 10,
          label: '10',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 11,
          value: 10,
          label: 'X',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ]
    ),
    TargetFace(
      id: 2,
      imageUrl: 'assets/target_faces/three.png',
      name: '3 spot',
      scores: [
        TargetFaceScore(
          id: 0,
          value: 0,
          label: 'M',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 6,
          value: 6,
          label: '6',
          color: Colors.blue,
        ),
        TargetFaceScore(
          id: 7,
          value: 7,
          label: '7',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 8,
          value: 8,
          label: '8',
          color: Colors.red,
        ),
        TargetFaceScore(
          id: 9,
          value: 9,
          label: '9',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 10,
          value: 10,
          label: '10',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 11,
          value: 10,
          label: 'X',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ]
    ),
    TargetFace(
      id: 3,
      imageUrl: 'assets/target_faces/outdoor.png',
      name: 'Outdoor',
      scores: [
        TargetFaceScore(
          id: 0,
          value: 0,
          label: 'M',
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 1,
          value: 1,
          label: '1',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 2,
          value: 2,
          label: '2',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 3,
          value: 3,
          label: '3',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 4,
          value: 4,
          label: '4',
          color: Colors.black,
        ),
        TargetFaceScore(
          id: 5,
          value: 5,
          label: '5',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        TargetFaceScore(
          id: 6,
          value: 6,
          label: '6',
          color: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ]
    ),
  ];
}