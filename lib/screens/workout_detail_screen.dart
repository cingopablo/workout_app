import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/countdown_circle.dart';
import '../widgets/custom_app_bar.dart';
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
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(
          milliseconds: 100,
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            child: child,
            scale: animation.drive(CurveTween(curve: Curves.easeOutQuint)),
          );
        },
        child: FloatingActionButton.extended(
          isExtended: true,
          onPressed: () {
            setState(() {
              _isPlaying = !_isPlaying;
            });
          },
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              ),
              _isPlaying ? Text('Pause') : Text('Start'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomCircularButton(
            function: () => Navigator.of(context).pop(),
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.close,
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
                Text(
                  'Workout time: 30:00',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.running,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('02:00'),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.coffee,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('00:30'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
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
      ),
    );
  }
}
