import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight = 100.0;

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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
