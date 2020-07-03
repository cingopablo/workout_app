import 'package:flutter/material.dart';

import '../screens/user_screen.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      // color: Colors.red,
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        // right: 25,
        // bottom: 10,
      ),
      child: Text(
        'My trainings',
        style: Theme.of(context).textTheme.headline1.copyWith(
              fontSize: 24,
            ),
      ),
    );
  }
}
