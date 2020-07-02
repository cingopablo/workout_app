import 'package:flutter/material.dart';

class CardWithTitle extends StatelessWidget {
  final String cardTitle;
  final Widget child;
  final double height;

  CardWithTitle({
    this.cardTitle,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[200],
            Colors.grey[50],
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(2.5, 2.5),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.1),
          ),
          BoxShadow(
            offset: Offset(-2.5, -3.5),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      height: height,
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.all(
        25,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cardTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          child,
          //TimerSelector(),
        ],
      ),
    );
  }
}
