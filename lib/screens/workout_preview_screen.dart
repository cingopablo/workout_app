import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../utils/format_time.dart';
import '../widgets/custom_flexible_bar.dart';
import '../screens/workout_timer_screen.dart';

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
                  //padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,

                  child: GridView.count(
                    childAspectRatio: 1.4,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_exercise.sets}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Sets',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_exercise.repetitions}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Repetitions',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${formatTime(
                                duration: _exercise.exerciseTime,
                              )}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Exercise',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${formatTime(
                                duration: _exercise.restTime,
                              )}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Rest',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${formatTime(
                                duration: _exercise.breakTime,
                              )}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Break',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2.5, 2.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(-2.5, -3.5),
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${formatTime(
                                duration: getTotalTime(_exercise),
                              )}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'Total time',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ],
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
