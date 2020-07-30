import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/exercise.dart';
import '../utils/format_time.dart';
import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../screens/workout_timer_screen.dart';
import '../widgets/workout_preview_screen/preview_tile.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  static const routeName = '/workout-detail';

  @override
  _WorkoutPreviewScreenState createState() => _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends State<WorkoutPreviewScreen> {
  AdmobInterstitial _admobInterstitial;

  @override
  initState() {
    super.initState();
    print('init admob');
    _admobInterstitial = AdmobInterstitial(
      adUnitId: 'ca-app-pub-3940256099942544/4411468910',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        print('listener');
        if (event == AdmobAdEvent.loaded) {
          print('admob loaded');
          _admobInterstitial.show();
        } else if (event == AdmobAdEvent.closed) {
          print('admob closed');
          _admobInterstitial.dispose();
        }
      },
    );
  }

  Duration getTotalTime(exercise) {
    return (exercise.exerciseTime * exercise.sets * exercise.repetitions) +
        (exercise.restTime * exercise.sets * (exercise.repetitions - 1)) +
        (exercise.breakTime * (exercise.sets - 1)) +
        exercise.coolDownTime;
  }

  @override
  Widget build(BuildContext context) {
    final loadedExercise =
        ModalRoute.of(context).settings.arguments as Exercise;

    Widget alertDialog() {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete this workout?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'No',
              style: Theme.of(context).textTheme.headline5,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(
              'Yes',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
              Provider.of<ExerciseProvider>(context, listen: false)
                  .deleteExercise(loadedExercise.id);
            },
          ),
        ],
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          Navigator.of(context).pushNamed(
            WorkoutTimerScreen.routeName,
            arguments: loadedExercise,
          );
        },
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          'Continue',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: loadedExercise.title.length > 10 ? 190 : 160,
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => alertDialog(),
                    );
                  },
                ),
              ],
              title:
                  Text('Preview', style: Theme.of(context).textTheme.headline6),
              flexibleSpace: FlexibleSpaceBar(
                background: CustomFlexibleBar(
                  now: DateTime.parse(loadedExercise.createdAt),
                  withDate: true,
                  title: loadedExercise.title,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: PreviewTile(
                          title: 'Sets',
                          value: loadedExercise.sets.toString(),
                          margin: const EdgeInsets.only(left: 25, right: 5),
                          icon: FaIcon(
                            FontAwesomeIcons.retweet,
                            size: 20,
                          ),
                        ),
                      ),
                      Flexible(
                        child: PreviewTile(
                          title: 'Reps',
                          value: loadedExercise.repetitions.toString(),
                          margin: const EdgeInsets.only(left: 5, right: 25),
                          icon: FaIcon(
                            FontAwesomeIcons.times,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PreviewTile(
                    title: 'Total time',
                    value: formatTime(duration: loadedExercise.getTotalTime()),
                    icon: FaIcon(
                      FontAwesomeIcons.stopwatch,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PreviewTile(
                    title: 'Exercise time',
                    value: formatTime(duration: loadedExercise.exerciseTime),
                    icon: FaIcon(
                      FontAwesomeIcons.running,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PreviewTile(
                    title: 'Rest time',
                    value: formatTime(duration: loadedExercise.restTime),
                    icon: FaIcon(
                      FontAwesomeIcons.couch,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PreviewTile(
                    title: 'Break',
                    value: formatTime(duration: loadedExercise.breakTime),
                    icon: FaIcon(
                      FontAwesomeIcons.coffee,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
