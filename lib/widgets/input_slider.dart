import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArrowLogInputSlider extends StatelessWidget {
  final double value;
  final void Function(double) onValueChanged;
  final double min;
  final double max;
  final int holdSpeed;

  const ArrowLogInputSlider({
    @required this.value,
    @required this.onValueChanged,
    @required this.min,
    @required this.max,
    this.holdSpeed = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PlusMinusButton(
          type: _PlusMinusType.MINUS,
          onChangeValue: () {
            if (value == min) return;
            onValueChanged(value - 1);
          },
          holdSpeed: holdSpeed,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackShape: _SliderNoMarginTrackShape(),
            ),
            child: Slider(
              value: value,
              onChanged: onValueChanged,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              inactiveColor: Colors.white54,
              activeColor: Colors.white,
            ),
          ),
        ),
        _PlusMinusButton(
          type: _PlusMinusType.PLUS,
          onChangeValue: () {
            if (value == max) return;
            onValueChanged(value + 1);
          },
          holdSpeed: holdSpeed,
        ),
      ],
    );
  }
}

enum _PlusMinusType {
  MINUS,
  PLUS
}

class _PlusMinusButton extends StatefulWidget {
  final VoidCallback onChangeValue;
  final _PlusMinusType type;
  final int holdSpeed;

  _PlusMinusButton({
    @required this.onChangeValue,
    @required this.type,
    @required this.holdSpeed,
  });

  @override
  __PlusMinusButtonState createState() => __PlusMinusButtonState();
}

class __PlusMinusButtonState extends State<_PlusMinusButton> {
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onChangeValue(),
      onTapDown: (_) => _timer = Timer.periodic(Duration(milliseconds: widget.holdSpeed), (__) => widget.onChangeValue()),
      onTapUp: (_) => _timer?.cancel(),
      onTapCancel: () => _timer?.cancel(),
      child: Padding(
        padding: EdgeInsets.only(
          top: 14.0,
          bottom: 14.0,
          left: widget.type == _PlusMinusType.MINUS ? 4.0 : 14.0,
          right: widget.type == _PlusMinusType.PLUS ? 4.0 : 14.0,
        ),
        child: Icon(
          widget.type == _PlusMinusType.MINUS ? FontAwesomeIcons.minus : FontAwesomeIcons.plus,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class _SliderNoMarginTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}