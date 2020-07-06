import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight = 80.0;

  final Widget child;
  final Color color;

  CustomAppBar({
    this.child,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: color,
        height: preferredHeight,
        padding: EdgeInsets.only(
          top: 20,
          left: 25,
          right: 25,
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
