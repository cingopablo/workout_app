import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screen/screen.dart';

import '../utils/get_icon.dart';
import '../models/workout.dart';
import '../models/settings.dart';
import '../models/exercise.dart';
import '../utils/step_name.dart';
import '../utils/format_time.dart';
import '../utils/get_background_color.dart';

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
      // _exercise,
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
    print(widget.selectedExercise);
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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.only(bottom: AppBar().preferredSize.height),
          // color: Colors.red,
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    .copyWith(fontSize: 120, height: 1.2),
              ),
              Text(
                '${formatTime(duration: formatTime(duration: _workout.totalTime) == '00:00' ? _workout.config.getTotalTime() : _workout.totalTime)}',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(height: 0.75),
              ),
              Text('Set: ${_workout.set} / ${_workout.config.sets}'),
              Text('Rep: ${_workout.rep} / ${_workout.config.repetitions}'),
              const SizedBox(
                height: 60,
              ),
              if (_workout.getNextStep() != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Coming next',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (_workout.getNextStep() != null)
                Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: getBackgroundColor(
                      workout: _workout,
                      context: context,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(getIcon(workout: _workout)),
                      const SizedBox(width: 10),
                      Text(_workout.getNextStep().toString()),
                    ],
                  ),
                ),
              if (_workout.getNextStep() == null)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 30,
                  color: Colors.red,
                )
            ],
          ),
        ),
      ),
    );
  }
}