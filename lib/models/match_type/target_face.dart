import 'dart:ui';

import 'package:flutter/material.dart';

class TargetFace {
  int id;
  String name;
  String imageUrl;
  List<TargetFaceScore> scores;

  TargetFace({
    this.id,
    this.name,
    this.imageUrl,
    this.scores,
  });
}

class TargetFaceScore {
  int id;
  int value;
  String label;
  Color color;
  Color foregroundColor;

  TargetFaceScore({
    this.id,
    this.value,
    this.label,
    this.color,
    this.foregroundColor = Colors.white,
  });
}