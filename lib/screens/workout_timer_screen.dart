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
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
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
              Text('Set: ${_workout.set} / ${_workout.config.sets}'),
              Text('Rep: ${_workout.rep} / ${_workout.config.repetitions}'),
              Text(
                  'Total time: ${formatTime(duration: _workout.totalTime)} / ${formatTime(duration: _workout.config.getTotalTime())}'),
            ],
          ),
        ),
      ),
    );
  }
}
