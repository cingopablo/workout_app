import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

import '../models/settings.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../utils/format_time.dart';
import '../utils/step_name.dart';

class WorkoutTimerScreen extends StatefulWidget {
  static const routeName = '/workout-timer';

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  Workout _workout;
  Exercise _exercise = Exercise(
    sets: 1,
    repetitions: 1,
    exerciseTime: const Duration(seconds: 10),
    restTime: const Duration(seconds: 5),
    breakTime: const Duration(seconds: 60),
  );
  Settings _settings = Settings();

  @override
  initState() {
    super.initState();
    _workout = Workout(
      _settings,
      _exercise,
      _onWorkoutChanged,
    );
  }

  @override
  dispose() {
    _workout.dispose();
    Screen.keepOn(false);
    super.dispose();
  }

  _onWorkoutChanged() {
    if (_workout.step == WorkoutState.finished) {
      Screen.keepOn(false);
    }
    this.setState(() {});
  }

  _getBackgroundColor() {
    switch (_workout.step) {
      case WorkoutState.exercising:
        return Colors.green;
      case WorkoutState.starting:
      case WorkoutState.resting:
        return Colors.blue;
      case WorkoutState.breaking:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  _pause() {
    _workout.pause();
    Screen.keepOn(false);
  }

  _start() {
    _workout.start();
    Screen.keepOn(true);
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
          onPressed: _workout.isActive ? _pause : _start,
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(_workout.isActive ? Icons.pause : Icons.play_arrow),
              ),
              _workout.isActive ? Text('Pause') : Text('Start workout'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
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
                top: 15,
              ),
              children: <Widget>[
                /* Text(
                  'Workout time: ${formatTime(_workout.config.getTotalTime())}',
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
                            Text(formatTime(_workout.config.getExerciseTime())),
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
                            Text(formatTime(_workout.config.getRestTime())),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ), */
                Text(
                  stepName(_workout.step),
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  formatTime(
                    duration:
                        _workout.timeLeft ?? _workout.config.getStartDelay(),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 100),
                ),
                Text(
                    '${formatTime(duration: _workout.totalTime)} / ${formatTime(duration: _workout.config.getTotalTime())}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
