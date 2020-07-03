import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight = 80.0;

  final Widget child;

  CustomAppBar({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
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
