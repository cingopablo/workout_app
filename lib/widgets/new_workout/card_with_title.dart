import 'package:flutter/material.dart';

class CardWithTitle extends StatelessWidget {
  final String cardTitle;
  final Widget child;
  final double height;

  CardWithTitle({
    this.cardTitle,
    this.child,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cardTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: height,
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
