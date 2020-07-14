import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_app/widgets/new_workout/number_selector.dart';

import '../utils/format_time.dart';
import '../providers/exercise_provider.dart';
import '../screens/workout_preview_screen.dart';
import '../widgets/new_workout/input_text.dart';
import '../widgets/new_workout/editable_tile.dart';
import '../widgets/new_workout/timer_selector.dart';

class NewWorkout extends StatefulWidget {
  static const routeName = '/new_workout';

  @override
  _NewWorkoutState createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  final _form = GlobalKey<FormState>();
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
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        icon: const Icon(Icons.save),
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
        label: const Text("Save"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title:
            Text('New workout', style: Theme.of(context).textTheme.headline6),
      ),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              InputText(
                initialValue: _initValues['title'],
                setValues: _setValues,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: EditableTile(
                      title: 'Sets',
                      value: _initValues['sets'].toString(),
                      margin: const EdgeInsets.only(left: 25, right: 5),
                      icon: FaIcon(
                        FontAwesomeIcons.retweet,
                        size: 20,
                      ),
                      timer: NumberSelector(
                        initialValue: _initValues['sets'],
                        setValues: _setValues,
                        valueKey: 'sets',
                      ),
                    ),
                  ),
                  Flexible(
                    child: EditableTile(
                      title: 'Reps',
                      value: _initValues['reps'].toString(),
                      margin: const EdgeInsets.only(left: 5, right: 25),
                      icon: FaIcon(
                        FontAwesomeIcons.times,
                        size: 20,
                      ),
                      timer: NumberSelector(
                        initialValue: _initValues['reps'],
                        setValues: _setValues,
                        valueKey: 'reps',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              EditableTile(
                title: 'Exercise time',
                value: formatTime(
                  duration: Duration(
                    minutes: _initValues['exercise_time_min'],
                    seconds: _initValues['exercise_time_sec'],
                  ),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.running,
                  size: 20,
                ),
                timer: TimerSelector(
                  initialValue: _initValues['exercise_time_min'],
                  initialValue2: _initValues['exercise_time_sec'],
                  setValues: _setValues,
                  key1: 'exercise_time_min',
                  key2: 'exercise_time_sec',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              EditableTile(
                title: 'Rest time',
                value: formatTime(
                  duration: Duration(
                    minutes: _initValues['resting_time_min'],
                    seconds: _initValues['resting_time_sec'],
                  ),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.couch,
                  size: 20,
                ),
                timer: TimerSelector(
                  initialValue: _initValues['resting_time_min'],
                  initialValue2: _initValues['resting_time_sec'],
                  setValues: _setValues,
                  key1: 'resting_time_min',
                  key2: 'resting_time_sec',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              EditableTile(
                title: 'Break',
                value: formatTime(
                  duration: Duration(
                    minutes: _initValues['break_time_min'],
                    seconds: _initValues['break_time_sec'],
                  ),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.coffee,
                  size: 20,
                ),
                timer: TimerSelector(
                  initialValue: _initValues['break_time_min'],
                  initialValue2: _initValues['break_time_sec'],
                  setValues: _setValues,
                  key1: 'break_time_min',
                  key2: 'break_time_sec',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
