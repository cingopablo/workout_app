import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/providers/exercise_provider.dart';

import '../screens/new_workout.dart';
import '../widgets/home_screen/workout_tile.dart';
import '../widgets/custom_flexible_bar.dart';

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
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _switchActionBar(true);
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _switchActionBar(false);
          break;
        // Idle - keep FAB visibility unchanged
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
          //onPressed: () {
          //Navigator.of(context).pushNamed(NewWorkout.routeName);

          //},
          onPressed: () => Provider.of<ExerciseProvider>(
            context,
            listen: false,
          ).addExercise(
            title: 'New timer',
            sets: 1,
            repetitions: 1,
            exerciseTime: const Duration(seconds: 10),
            restTime: const Duration(seconds: 5),
            breakTime: const Duration(seconds: 60),
          ),
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
        child: CustomScrollView(
          controller: _scrollController,
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
            FutureBuilder(
              future: Provider.of<ExerciseProvider>(context, listen: false)
                  .fetchAndSetExercises(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? SliverToBoxAdapter(
                          child: Text('sliver box'),
                        )
                      : Consumer<ExerciseProvider>(
                          child: SliverToBoxAdapter(
                            child: Center(
                              child: const Text(
                                  'Got no timers yet. Start adding some!'),
                            ),
                          ),
                          builder: (ctx, exercises, ch) =>
                              exercises.items.length <= 0
                                  ? ch
                                  : SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (ctx, index) => WorkoutTile(),
                                        childCount: exercises.items.length,
                                      ),
                                    ),
                        ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (ctx, index) => WorkoutTile(),
            //     childCount: 10,
            //   ),
            // ),
          ],
        ),

        // child: FutureBuilder(
        //     future: Provider.of<ExerciseProvider>(context, listen: false)
        //         .fetchAndSetExercises(),
        //     builder: (context, snapshot) {
        //       Widget newsListSliver;

        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         newsListSliver = Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }

        //       if (snapshot.hasData) {
        //         newsListSliver = SliverList(
        //           delegate: SliverChildBuilderDelegate(
        //             (ctx, index) => WorkoutTile(),
        //             childCount: 10,
        //           ),
        //         );
        //       } else {
        //         newsListSliver = SliverToBoxAdapter(
        //           child: Text('No data'),
        //         );
        //       }

        //       return CustomScrollView(
        //         controller: _scrollController,
        //         slivers: <Widget>[
        //           SliverAppBar(
        //             elevation: 0,
        //             expandedHeight: 160,
        //             iconTheme: const IconThemeData(color: Colors.black),
        //             backgroundColor: Theme.of(context).backgroundColor,
        //             pinned: true,
        //             floating: true,
        //             primary: true,
        //             centerTitle: true,
        //             title: Text('My workouts',
        //                 style: Theme.of(context).textTheme.headline6),
        //             flexibleSpace: FlexibleSpaceBar(
        //               background: CustomFlexibleBar(
        //                 now: now,
        //                 withDate: true,
        //                 title: 'Hello there',
        //               ),
        //             ),
        //           ),
        //           newsListSliver,
        //         ],
        //       );
        //     }),
      ),
    );
  }
}

// child: CustomScrollView(
//   controller: _scrollController,
//   slivers: <Widget>[
//     SliverAppBar(
//       elevation: 0,
//       expandedHeight: 160,
//       iconTheme: const IconThemeData(color: Colors.black),
//       backgroundColor: Theme.of(context).backgroundColor,
//       pinned: true,
//       floating: true,
//       primary: true,
//       centerTitle: true,
//       title: Text('My workouts',
//           style: Theme.of(context).textTheme.headline6),
//       flexibleSpace: FlexibleSpaceBar(
//         background: CustomFlexibleBar(
//           now: now,
//           withDate: true,
//           title: 'Hello there',
//         ),
//       ),
//     ),
//     SliverList(

//       delegate: SliverChildBuilderDelegate(

//         (ctx, index) => WorkoutTile(),
//         childCount: 10,
//       ),
//     ),
//   ],
// ),
