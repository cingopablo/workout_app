import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/custom_flexible_bar.dart';
import '../screens/workout_timer_screen.dart';
import '../widgets/workout_preview_screen/preview_tile.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  static const routeName = '/workout-detail';

  @override
  _WorkoutPreviewScreenState createState() => _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends State<WorkoutPreviewScreen> {
  var now = DateTime.now();
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
                background: CustomFlexibleBar(
                  now: now,
                  withDate: true,
                  title: 'Skipping rope',
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
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
                      exercise: _exercise,
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
