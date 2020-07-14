import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
          //height: 130.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat.yMMMMd()
                        .format(DateTime.parse(exercise.createdAt)),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    exercise.title,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 20,
                          color: Color(0xFF510EC3),
                        ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${formatTime(
                            duration: exercise.getTotalTime(),
                            isPreview: true,
                          )}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        VerticalDivider(
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '${exercise.sets.toString()} ${exercise.sets > 1 ? 'Sets.' : 'Set.'}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        VerticalDivider(
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '${exercise.repetitions.toString()} ${exercise.repetitions > 1 ? 'Reps.' : 'Rep.'}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
