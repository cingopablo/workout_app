import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool withIcon;
  final Widget icon;

  CustomButton({
    @required this.onPressed,
    @required this.text,
    this.withIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      child: Container(
          height: 46.0,
          width: 172.0,
          child: RaisedButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF510EC3),
                    Color(0xFFA865D4),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(80.0),
                ),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 88.0,
                  minHeight: 36.0,
                ), // min sizes for Material buttons
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (withIcon) icon,
                    if (withIcon)
                      SizedBox(
                        width: 10,
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
