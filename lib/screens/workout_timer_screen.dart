import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

import '../models/workout.dart';
import '../models/settings.dart';
import '../models/exercise.dart';
import '../utils/get_background_color.dart';
import '../widgets/workout_timer_screen/timer_body.dart';
import '../widgets/workout_timer_screen/timer_head.dart';

class WorkoutTimerScreen extends StatefulWidget {
  static const routeName = '/workout-timer';
  final Exercise selectedExercise;

  WorkoutTimerScreen({this.selectedExercise});

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  Workout _workout;
  Settings _settings = Settings();

  @override
  initState() {
    super.initState();
    _workout = Workout(
      _settings,
      widget.selectedExercise,
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
    print(_workout.current);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: _workout.isActive ? _pause : _start,
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(_workout.isActive ? Icons.pause : Icons.play_arrow),
        label: _workout.isActive
            ? const Text('Pause')
            : const Text('Start workout'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: getBackgroundColor(workout: _workout.step),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TimerHead(workout: _workout),
            TimerBody(workout: _workout),
          ],
        ),
      ),
    );
  }
}
