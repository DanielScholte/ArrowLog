import 'package:flutter/material.dart';

class ArrowLogListView extends StatelessWidget {
  final List<Widget> children;
  final bool enableSafeArea;

  ArrowLogListView({
    @required this.children,
    this.enableSafeArea = true
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPadding = MediaQuery
      .of(context)
      .padding;

    return ListView(
      padding: defaultPadding
        .copyWith(
          top: 6.0,
          left: 0.0,
          right: 0.0,
          bottom: defaultPadding.bottom > 6.0 && enableSafeArea ? defaultPadding.bottom : 6.0
        ),
      children: children,
    );
  }
}