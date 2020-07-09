import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/workout_timer_screen.dart';
import '../models/exercise.dart';
import '../utils/format_time.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  static const routeName = '/workout-detail';

  @override
  _WorkoutPreviewScreenState createState() => _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends State<WorkoutPreviewScreen> {
  Exercise _exercise = Exercise(
    sets: 1,
    repetitions: 1,
    exerciseTime: const Duration(seconds: 10),
    restTime: const Duration(seconds: 5),
    breakTime: const Duration(seconds: 60),
  );

  Duration getTotalTime(exercise) {
    return (exercise.exerciseTime * exercise.sets * exercise.repetitions) +
        (exercise.restTime * exercise.sets * (exercise.repetitions - 1)) +
        (exercise.breakTime * (exercise.sets - 1)) +
        exercise.coolDownTime;
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
            Navigator.of(context).pushNamed(WorkoutTimerScreen.routeName);
          },
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: Text('Continue'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 200,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Theme.of(context).backgroundColor,
              pinned: true,
              floating: true,
              primary: true,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {},
                ),
              ],
              title:
                  Text('Preview', style: Theme.of(context).textTheme.headline6),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Jul 8, 2020',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Skipping rope',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          'Total time ${formatTime(isPreview: true, duration: getTotalTime(_exercise))}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) => Column(
                  children: <Widget>[
                    Text('Set ${index + 1}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.running,
                          size: 34,
                        ),
                        Text('Exercise'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(formatTime(
                          isPreview: true,
                          duration: _exercise.exerciseTime,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.coffee,
                          size: 34,
                        ),
                        Text('Rest Time'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(formatTime(
                          isPreview: true,
                          duration: _exercise.restTime,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.running,
                          size: 34,
                        ),
                        Text('Repetitions'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(_exercise.repetitions.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.coffee,
                          size: 34,
                        ),
                        Text('Break Time'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(formatTime(
                          isPreview: true,
                          duration: _exercise.breakTime,
                        )),
                      ],
                    ),
                  ],
                ),
                // childCount: _exercise.sets,
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
