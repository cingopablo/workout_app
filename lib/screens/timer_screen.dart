import 'package:flutter/material.dart';
import 'package:workout_app/widgets/countdown_circle.dart';
import 'package:workout_app/widgets/custom_app_bar.dart';
import 'package:workout_app/widgets/custom_button.dart';
import 'package:workout_app/widgets/custom_circular_button.dart';

class TimerScreen extends StatefulWidget {
  static const routeName = '/timer-screen';

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool _isPlaying = false;

  void _setPlaying(bool playing) {
    setState(() {
      _isPlaying = playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomCircularButton(
              function: () => Navigator.of(context).pop(),
              backgroundColor: Theme.of(context).backgroundColor,
              icon: Icons.close,
              iconColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
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
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
                //Navigator.of(context).pushNamed(TimerScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
