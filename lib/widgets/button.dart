import 'package:flutter/material.dart';

class ArrowLogButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final EdgeInsets margin;
  final double width;

  ArrowLogButton({
    @required this.text,
    @required this.onTap,
    this.color,
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: margin,
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: color != null ? color : Theme.of(context).accentColor,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
        ),
        onPressed: () => onTap(),
      ),
    );
  }
}