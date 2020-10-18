import 'package:flutter/material.dart';

class ArrowLogInputSlider extends StatelessWidget {
  final double value;
  final void Function(double) onValueChanged;
  final double min;
  final double max;

  const ArrowLogInputSlider({
    @required this.value,
    @required this.onValueChanged,
    @required this.min,
    @required this.max
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: onValueChanged,
      min: min,
      max: max,
      divisions: (max - min).toInt(),
      inactiveColor: Colors.white54,
      activeColor: Colors.white,
    );
  }
}