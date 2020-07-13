import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../models/exercise.dart';
import '../../utils/format_time.dart';
import '../../screens/workout_preview_screen.dart';

class WorkoutTile extends StatelessWidget {
  final Exercise exercise;

  const WorkoutTile({
    this.exercise,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.4),
          ),
          BoxShadow(
            offset: const Offset(-2, -2),
            blurRadius: 8,
            color: Colors.grey[50].withOpacity(0.3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        left: 25.0,
        top: 0.0,
        right: 25.0,
        bottom: 15.0,
      ),
      child: GestureDetector(
          onTap: () => {
                Navigator.of(context).pushNamed(
                  WorkoutPreviewScreen.routeName,
                  arguments: exercise,
                ),
              },
          child: Container(
            width: double.infinity,
            //height: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              //   colors: [
              //     const Color(0xffEEEEEE).withOpacity(0.6),
              //     const Color(0xffFAFAFA).withOpacity(0.75),
              //   ],
              // ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(exercise.createdAt)),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        exercise.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const FaIcon(FontAwesomeIcons.stopwatch),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                formatTime(
                                  duration: exercise.getTotalTime(),
                                ),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'SETS: ${exercise.sets.toString()}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'REPS: ${exercise.repetitions.toString()}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 36,
                  ),
                ],
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Row(
              //       children: <Widget>[
              //         Wrap(
              //           direction: Axis.vertical,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: <Widget>[
              //             Text(
              //               formatTime(duration: exercise.getTotalTime()),
              //               style:
              //                   Theme.of(context).textTheme.headline2.copyWith(
              //                         color: Colors.black,
              //                         //height: 1,
              //                       ),
              //             ),
              //             Text(
              //               'Time',
              //               style:
              //                   Theme.of(context).textTheme.headline6.copyWith(
              //                       //        height: 0.8,
              //                       ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(
              //           width: 20,
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(
              //               exercise.title,
              //               style: Theme.of(context).textTheme.headline6,
              //             ),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: <Widget>[
              //                 Row(
              //                   children: <Widget>[
              //                     const FaIcon(
              //                       FontAwesomeIcons.running,
              //                       size: 18,
              //                     ),
              //                     const SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(formatTime(
              //                       duration: exercise.exerciseTime,
              //                     )),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Row(
              //                   children: <Widget>[
              //                     const FaIcon(
              //                       FontAwesomeIcons.coffee,
              //                       size: 18,
              //                     ),
              //                     const SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(formatTime(
              //                       duration: exercise.restTime,
              //                     )),
              //                   ],
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //     const Icon(
              //       Icons.chevron_right,
              //       size: 36,
              //     ),
              //   ],
              // ),
            ),
          )),
    );
  }
}
