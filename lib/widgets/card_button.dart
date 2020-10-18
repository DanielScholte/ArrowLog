import 'package:arrow_log/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArrowLogCardButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool includeArrow;

  ArrowLogCardButton({
    @required this.onTap,
    @required this.child,
    this.padding = const EdgeInsets.all(12.0),
    this.margin = const EdgeInsets.all(8.0),
    this.includeArrow = true
  });

  @override
  Widget build(BuildContext context) {
    return ArrowLogCard(
      margin: margin,
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: onTap != null ? () => onTap() : null,
          child: Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: child),
                if (includeArrow)
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.white,
                    size: 18.0,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}