import 'package:flutter/material.dart';
import 'package:workout_app/screens/new_workout.dart';
import 'package:workout_app/widgets/custom_button.dart';
import 'package:workout_app/widgets/workout_tile.dart';

import '../widgets/main_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 150,
                  backgroundColor: Theme.of(context).backgroundColor,
                  pinned: true,
                  primary: true,
                  bottom: PreferredSize(
                    child: Text(''),
                    preferredSize: Size.fromHeight(40.0),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: MainHeader(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => WorkoutTile(),
                    childCount: 10,
                  ),
                ),
              ],
            ),
          ),
          CustomButton(onPressed: () {
            Navigator.of(context).pushNamed(NewWorkout.routeName);
          }),
        ],
      ),
    );
  }
}
