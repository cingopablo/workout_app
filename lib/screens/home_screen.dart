import 'package:flutter/material.dart';

import '../screens/new_workout.dart';
import '../widgets/custom_button.dart';
import '../widgets/workout_tile.dart';
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
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              transform: Matrix4.translationValues(30, -80, 0),
              width: 50,
              height: 50,
              child: Image.asset('assets/images/imagen.png'),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              transform: Matrix4.translationValues(90, 0, 0),
              width: 200,
              height: 200,
              child: Image.asset('assets/images/imagen.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              transform: Matrix4.translationValues(-90, 0, 0),
              width: 200,
              height: 200,
              child: Image.asset('assets/images/imagen.png'),
            ),
          ),
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
          CustomButton(
            text: 'Add workout',
            onPressed: () {
              Navigator.of(context).pushNamed(NewWorkout.routeName);
            },
          ),
        ],
      ),
    );
  }
}
