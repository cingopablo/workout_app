import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../screens/new_workout.dart';
import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../widgets/home_screen/workout_tile.dart';

class HomeScreen extends StatelessWidget {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () => Navigator.of(context).pushNamed(NewWorkout.routeName),
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        label: const Text("Add workout"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<ExerciseProvider>(context, listen: false)
              .fetchAndSetExercises(),
          builder: (context, snapshot) {
            Widget newsListSliver;
            if (snapshot.connectionState != ConnectionState.waiting) {
              newsListSliver = Consumer<ExerciseProvider>(
                child: Center(
                  child: const Text('Got no exercises yet. Start adding some!'),
                ),
                builder: (ctx, exercises, ch) => exercises.items.length <= 0
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => Container(
                            margin: const EdgeInsets.only(left: 10, top: 30),
                            child: Lottie.asset('assets/images/warmup.json'),
                          ),
                          childCount: 1,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) =>
                              WorkoutTile(exercise: exercises.items[index]),
                          childCount: exercises.items.length,
                        ),
                      ),
              );
            } else {
              newsListSliver = SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => CircularProgressIndicator(),
                  childCount: 1,
                ),
              );
            }

            return CustomScrollView(
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
                  title: Text('My workouts',
                      style: Theme.of(context).textTheme.headline6),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomFlexibleBar(
                      now: now,
                      withDate: true,
                      title: snapshot.hasData
                          ? 'Ready to train?'
                          : 'No workouts yet',
                    ),
                  ),
                ),
                newsListSliver,
              ],
            );
          },
        ),
      ),
    );
  }
}
