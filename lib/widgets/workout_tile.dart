import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/workout_detail_screen.dart';

class WorkoutTile extends StatelessWidget {
  const WorkoutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
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
                    borderRadius: BorderRadius.circular(20.0),
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
                                      .headline2
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Skipping rope',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.running,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('02:00'),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.coffee,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('00:30'),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
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
