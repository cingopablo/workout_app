import 'dart:ui';

import 'package:flutter/material.dart';

import '../screens/workout_detail_screen.dart';

class WorkoutTile extends StatelessWidget {
  const WorkoutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.4),
          ),
          BoxShadow(
            offset: Offset(-2, -2),
            blurRadius: 8,
            color: Colors.grey[50].withOpacity(0.3),
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(
        25.0,
        8.0,
        25.0,
        15.0,
      ),
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).pushNamed(WorkoutDetailScreen.routeName),
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 108.0,
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(2.5, 2.5),
                    //     blurRadius: 8,
                    //     color: Colors.white38,
                    //   ),
                    //   BoxShadow(
                    //     offset: Offset(-2.5, -2.5),
                    //     blurRadius: 8,
                    //     color: Colors.white38,
                    //   ),
                    // ],
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        // Theme.of(context).primaryColor,
                        // Theme.of(context).accentColor,
                        Color(0xffEEEEEE).withOpacity(0.6),
                        Color(0xffFAFAFA).withOpacity(0.75),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Text(
                                  '2',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        color: Colors.black,
                                        height: 1,
                                      ),
                                ),
                                Text(
                                  'sets',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        height: 0.8,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Skipping rope',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  'Workout time: 30 min',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(height: 2.0),
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
