import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final bool isLeftPositioned;
  final Widget icon;

  CustomFloatingButton({
    this.isLeftPositioned = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftPositioned
          ? const EdgeInsets.only(
              top: 150.0,
              left: 10,
            )
          : const EdgeInsets.only(
              top: 150.0,
              right: 10,
            ),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: Offset(2.5, 2.5),
              blurRadius: 8,
              color: Colors.grey.withOpacity(0.35),
            ),
            BoxShadow(
              offset: Offset(-0.5, -0.5),
              blurRadius: 8,
              color: Colors.grey.withOpacity(0.35),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 0,
          child: icon,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
