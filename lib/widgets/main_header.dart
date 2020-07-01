import 'package:flutter/material.dart';

import '../screens/user_detail_screen.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            children: <Widget>[
              Text(
                'Wed, 1 July',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 11,
                    ),
              ),
              Text(
                'My trainings',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => {
              Navigator.of(context).pushNamed(UserScreen.routeName),
            },
            child: Hero(
              tag: 'imageUrl',
              child: CircleAvatar(
                radius: 23.0,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/82.jpg',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
