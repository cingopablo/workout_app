import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final Function function;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  CustomCircularButton({
    this.function,
    this.backgroundColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
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
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
