import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewTile extends StatelessWidget {
  const PreviewTile({
    Key key,
    @required this.value,
    @required this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 25),
    @required this.icon,
  }) : super(key: key);

  final String value;
  final String title;
  final EdgeInsetsGeometry margin;
  final FaIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: 10,
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          )
        ],
      ),
    );
  }
}
