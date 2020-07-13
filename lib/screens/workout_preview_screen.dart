import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../screens/workout_timer_screen.dart';
import '../widgets/workout_preview_screen/preview_tile.dart';

class WorkoutPreviewScreen extends StatelessWidget {
  static const routeName = '/workout-detail';

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
        label: const Text('Continue'),
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
              delegate: SliverChildListDelegate.fixed([
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (ctx, index) => PreviewTile(
                      exercise: loadedExercise,
                      index: index,
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
