import 'package:flutter/material.dart';

import '../widgets/countdown_circle.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';

class WorkoutDetailScreen extends StatefulWidget {
  static const routeName = '/workout-detail';

  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  bool _isPlaying = false;

  void _setPlaying(bool playing) {
    setState(() {
      _isPlaying = playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: TabsScreen(),
      appBar: CustomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomCircularButton(
            function: () => Navigator.of(context).pop(),
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.chevron_left,
            iconColor: Theme.of(context).primaryColor,
          ),
          CustomCircularButton(
            function: () => print('delete'),
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.delete_outline,
            iconColor: Theme.of(context).errorColor,
          ),
        ],
      )),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 30,
                top: 15,
              ),
              children: <Widget>[
                Text(
                  'Skipping rope',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Workout time',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      '30 min',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
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
                    CountdownCircle(
                      workMinutes: 1,
                      workSeconds: 0,
                      restMinutes: 0,
                      restSeconds: 30,
                      repetitions: 2,
                      isPlaying: _isPlaying,
                      setPlaying: _setPlaying,
                    ),
                  ],
                ),
              ],
            ),
            CustomButton(
                text: _isPlaying ? 'Pause' : 'Start',
                withIcon: true,
                icon: _isPlaying
                    ? Icon(
                        Icons.pause,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                onPressed: () {
                  setState(
                    () {
                      _isPlaying = !_isPlaying;
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
