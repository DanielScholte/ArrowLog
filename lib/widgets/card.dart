import 'package:flutter/material.dart';

class ArrowLogCard extends StatelessWidget {
  final Widget header;
  final Widget footer;
  final Widget child;
  final EdgeInsets paddingHeader;
  final EdgeInsets padding;
  final EdgeInsets paddingFooter;
  final EdgeInsets margin;
  final CrossAxisAlignment alignment;

  ArrowLogCard({
    @required this.child,
    this.paddingHeader = const EdgeInsets.all(12.0),
    this.padding = const EdgeInsets.all(12.0),
    this.paddingFooter = const EdgeInsets.all(12.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    this.alignment = CrossAxisAlignment.center,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    if (header != null || footer != null) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: margin,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (header != null)
              Padding(
                padding: paddingHeader,
                child: header,
              ),
            _buildCardContent(context),
            if (footer != null)
              Padding(
                padding: paddingFooter,
                child: footer,
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: margin,
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      width: double.infinity,
      padding: this.padding,
      child: child,
    );
  }
}