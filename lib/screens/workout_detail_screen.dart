import 'package:flutter/material.dart';

import '../screens/timer_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_floating_button.dart';

class WorkoutDetailScreen extends StatelessWidget {
  static const routeName = '/workout-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        isLeftPositioned: true,
        icon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 100,
                bottom: 30,
              ),
              children: <Widget>[
                Text(
                  'Skipping rope',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Workout name',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ],
            ),
            CustomButton(
              text: 'Start',
              onPressed: () {
                Navigator.of(context).pushNamed(TimerScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
