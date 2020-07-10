import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/exercise.dart';
import '../../utils/format_time.dart';

class SetTiles extends StatelessWidget {
  const SetTiles({
    Key key,
    @required Exercise exercise,
    @required this.index,
  })  : _exercise = exercise,
        super(key: key);

  final Exercise _exercise;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Set ${index + 1}',
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.running,
              size: 34,
            ),
            Text('Repetitions'),
            SizedBox(
              width: 5,
            ),
            Text(_exercise.repetitions.toString()),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          //height: 100,
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.running,
                size: 34,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Exercise ${formatTime(
                      isPreview: true,
                      duration: _exercise.exerciseTime,
                    )}',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Rest Time ${formatTime(
                      isPreview: true,
                      duration: _exercise.restTime,
                    )}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          //height: 100,
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.coffee,
                size: 22,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Break Time ${formatTime(
                  isPreview: true,
                  duration: _exercise.breakTime,
                )}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
