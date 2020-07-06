import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screens/new_workout.dart';
import '../widgets/workout_tile.dart';
import '../widgets/main_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  bool _isExtended = true;

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
          onPressed: () {
            Navigator.of(context).pushNamed(NewWorkout.routeName);
          },
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: _isExtended
              ? Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.add),
                    ),
                    Text("Add training"),
                  ],
                )
              : Icon(Icons.add),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   isExtended: _isExtended,
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(NewWorkout.routeName);
      //   },
      //   elevation: 2,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   foregroundColor: Colors.white,
      //   label: _isExtended
      //       ? Row(
      //           children: <Widget>[
      //             Padding(
      //               padding: const EdgeInsets.only(right: 8.0),
      //               child: Icon(Icons.add),
      //             ),
      //             Text("Add training"),
      //           ],
      //         )
      //       : Icon(Icons.add),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Stack(
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
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                transform: Matrix4.translationValues(-80, -45, 0),
                width: 70,
                height: 70,
                child: Image.asset('assets/images/imagen.png'),
              ),
            ),
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 160,
                  backgroundColor: Theme.of(context).backgroundColor,
                  pinned: true,
                  primary: true,
                  bottom: PreferredSize(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        transform: Matrix4.translationValues(-35, -80, 0),
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/imagen.png'),
                      ),
                    ),
                    preferredSize: Size.fromHeight(20.0),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsetsDirectional.only(start: 0, bottom: 15),
                    centerTitle: false,
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
          ],
        ),
      ),
    );
  }
}
