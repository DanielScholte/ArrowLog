import 'package:flutter/material.dart';

class ArrowLogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool displayLogo;
  final List<Widget> actions;

  ArrowLogAppBar({
    @required this.title,
    this.displayLogo = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Theme.of(context).brightness,
      centerTitle: true,
      title: displayLogo ? _buildLogo(context) : Text(
        title,
        style: Theme.of(context).textTheme.headline1
      ),
      actions: actions,
      elevation: 4,
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 32,
          height: 32,
        ),
        Container(width: 4,),
        Text(
          'ArrowLog',
          style: Theme.of(context).textTheme.headline1
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}