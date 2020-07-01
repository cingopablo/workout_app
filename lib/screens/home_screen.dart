import 'package:flutter/material.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   elevation: 0,
      // ),
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
          CustomButton(),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      child: Container(
          height: 46.0,
          width: 172.0,
          child: RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF510EC3),
                    Color(0xFFA865D4),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(80.0),
                ),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 88.0,
                  minHeight: 36.0,
                ), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Add workout',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}
