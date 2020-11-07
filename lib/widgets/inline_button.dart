import 'package:flutter/material.dart';

class ArrowLogInlineButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double textSize;

  ArrowLogInlineButton({
    @required this.text,
    @required this.onTap,
    this.color,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(6.0),
    this.width = double.infinity,
    this.textSize = 18.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color == null ? Theme.of(context).scaffoldBackgroundColor : null,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: color != null ? color : Theme.of(context).buttonColor,
          width: 2.0,
        ),
      ),
      margin: margin,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: padding,
              child: Text(
                text,
                style: TextStyle(
                  color: color != null ? color : Theme.of(context).buttonColor,
                  fontSize: textSize
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}