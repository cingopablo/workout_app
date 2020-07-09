import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomFlexibleBar extends StatelessWidget {
  const CustomFlexibleBar({
    Key key,
    @required this.now,
    this.withDate = false,
    @required this.title,
  }) : super(key: key);

  final DateTime now;
  final bool withDate;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Container(
        margin: withDate
            ? const EdgeInsets.only(top: 70)
            : const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (withDate)
              Text(
                DateFormat.yMMMMd().format(now),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
