import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../screens/new_workout.dart';
import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../widgets/home_screen/workout_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  bool _isExtended = true;
  var now = DateTime.now();

  void _switchActionBar(value) {
    setState(() {
      _isExtended = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _switchActionBar(true);
          break;
        case ScrollDirection.reverse:
          _switchActionBar(false);
          break;
        case ScrollDirection.idle:
          break;
      }
    });
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
          isExtended: _isExtended,
          onPressed: () {
            Navigator.of(context).pushNamed(NewWorkout.routeName);
          },
          // onPressed: () => Provider.of<ExerciseProvider>(
          //   context,
          //   listen: false,
          // ).addExercise(
          //   title: 'New timer',
          //   sets: 1,
          //   repetitions: 1,
          //   exerciseTime: const Duration(seconds: 10),
          //   restTime: const Duration(seconds: 5),
          //   breakTime: const Duration(seconds: 60),
          // ),
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: _isExtended
              ? Row(
                  children: <Widget>[
                    const Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.add),
                    ),
                    const Text("Add training"),
                  ],
                )
              : const Icon(Icons.add),
        ),
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
                          (ctx, index) => Text('No items'),
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
              newsListSliver = SliverToBoxAdapter(
                child: CircularProgressIndicator(),
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
                      title: 'Hello there',
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
