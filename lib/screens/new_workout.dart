import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../screens/workout_preview_screen.dart';
import '../widgets/new_workout/input_text.dart';
import '../widgets/new_workout/timer_selector.dart';
import '../widgets/new_workout/card_with_title.dart';

class NewWorkout extends StatefulWidget {
  static const routeName = '/new_workout';

  @override
  _NewWorkoutState createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  var _now = DateTime.now();
  var _initValues = {
    'title': '',
    'sets': 1,
    'reps': 1,
    'exercise_time_min': 0,
    'exercise_time_sec': 0,
    'resting_time_min': 0,
    'resting_time_sec': 0,
    'break_time_min': 0,
    'break_time_sec': 0,
  };

  void _setValues({key, value}) {
    setState(() {
      _initValues[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final id = uuid.v4();

    bool shouldWeSave() {
      if (_initValues['title'].toString().length == 0) return false;

      if (_initValues['exercise_time_min'] == 0 &&
          _initValues['exercise_time_sec'] == 0) return false;

      if (_initValues['resting_time_min'] == 0 &&
          _initValues['resting_time_sec'] == 0) return false;

      return true;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
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
          onPressed: shouldWeSave()
              ? () {
                  Navigator.of(context).pop();
                  Provider.of<ExerciseProvider>(
                    context,
                    listen: false,
                  ).addExercise(
                    title: _initValues['title'],
                    id: id,
                    sets: _initValues['sets'],
                    repetitions: _initValues['reps'],
                    exerciseTime: Duration(
                      minutes: _initValues['exercise_time_min'],
                      seconds: _initValues['exercise_time_sec'],
                    ),
                    restTime: Duration(
                      minutes: _initValues['resting_time_min'],
                      seconds: _initValues['resting_time_sec'],
                    ),
                    breakTime: Duration(
                      minutes: _initValues['break_time_min'],
                      seconds: _initValues['break_time_sec'],
                    ),
                  );
                  Navigator.of(context).pushNamed(
                    WorkoutPreviewScreen.routeName,
                    arguments:
                        Provider.of<ExerciseProvider>(context, listen: false)
                            .findById(id),
                  );
                }
              : null,
          elevation: 2,
          backgroundColor:
              shouldWeSave() ? Theme.of(context).primaryColor : Colors.grey,
          foregroundColor: Colors.white,
          label: Row(
            children: <Widget>[
              const Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Icon(Icons.save),
              ),
              const Text("Save"),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 160,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Theme.of(context).backgroundColor,
              pinned: true,
              floating: true,
              primary: true,
              centerTitle: true,
              title: Text('New workout',
                  style: Theme.of(context).textTheme.headline6),
              flexibleSpace: FlexibleSpaceBar(
                background: CustomFlexibleBar(
                  now: _now,
                  title: 'Add a workout',
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                InputText(setValues: _setValues),
                CardWithTitle(
                  height: 80,
                  cardTitle: 'Number of sets',
                  child: TimerSelector(
                    initialValue: _initValues['sets'],
                    setValues: _setValues,
                    key1: 'sets',
                    isTime: false,
                  ),
                ),
                CardWithTitle(
                  height: 80,
                  cardTitle: 'Number of repetitions',
                  child: TimerSelector(
                    initialValue: _initValues['reps'],
                    setValues: _setValues,
                    key1: 'reps',
                    isTime: false,
                  ),
                ),
                CardWithTitle(
                  cardTitle: 'Exercise time',
                  child: TimerSelector(
                      initialValue: _initValues['exercise_time_min'],
                      initialValue2: _initValues['exercise_time_sec'],
                      setValues: _setValues,
                      key1: 'exercise_time_min',
                      key2: 'exercise_time_sec'),
                ),
                CardWithTitle(
                  cardTitle: 'Resting time',
                  child: TimerSelector(
                      initialValue: _initValues['resting_time_min'],
                      initialValue2: _initValues['resting_time_sec'],
                      setValues: _setValues,
                      key1: 'resting_time_min',
                      key2: 'resting_time_sec'),
                ),
                CardWithTitle(
                  cardTitle: 'Break between sets',
                  child: TimerSelector(
                      initialValue: _initValues['break_time_min'],
                      initialValue2: _initValues['break_time_sec'],
                      setValues: _setValues,
                      key1: 'break_time_min',
                      key2: 'break_time_sec'),
                ),
                const SizedBox(
                  height: 45,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
