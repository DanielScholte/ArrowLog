import 'package:flutter/material.dart';

class ArrowLogInfoBlock extends StatelessWidget {
  final String header;
  final String value;
  final Widget child;
  final double fontSize;
  final double secondaryFontSize;

  ArrowLogInfoBlock({
    @required this.header,
    this.value,
    this.fontSize = 16,
    this.secondaryFontSize,
    this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          if (value != null)
            Text(
              value,
              style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: fontSize,
                color: Colors.white,
              )
            ),
          if (child != null)
            child,
          Text(
            header,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: secondaryFontSize != null ? secondaryFontSize : fontSize - 2,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}