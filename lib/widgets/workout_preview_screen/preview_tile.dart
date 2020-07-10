import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_app/utils/format_time.dart';

import '../../models/exercise.dart';

class PreviewTile extends StatelessWidget {
  final Exercise exercise;
  final int index;

  PreviewTile({
    this.exercise,
    this.index,
  });

  dynamic getValue(Exercise ex, int idx) {
    switch (idx) {
      case 0:
        return {
          'value': ex.sets,
          'text': 'Sets',
          'icon': FontAwesomeIcons.times,
        };
        break;
      case 1:
        return {
          'value': ex.repetitions,
          'text': 'Reps',
          'icon': FontAwesomeIcons.retweet,
        };
        break;
      case 2:
        return {
          'value': ex.exerciseTime,
          'text': 'Exercise',
          'icon': FontAwesomeIcons.running,
        };
        break;
      case 3:
        return {
          'value': ex.restTime,
          'text': 'Rest',
          'icon': FontAwesomeIcons.couch,
        };
        break;
      case 4:
        return {
          'value': ex.breakTime,
          'text': 'Break',
          'icon': FontAwesomeIcons.coffee,
        };
        break;
      case 5:
        return {
          'value': ex.getTotalTime(),
          'text': 'Total time',
          'icon': FontAwesomeIcons.stopwatch,
        };
        break;
      default:
        return {'value': 0, 'text': ''};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(2.5, 2.5),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.1),
          ),
          BoxShadow(
            offset: const Offset(-2.5, -3.5),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            index > 1
                ? '${formatTime(duration: getValue(exercise, index)['value'])}'
                : '${getValue(exercise, index)['value']}',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FaIcon(
                getValue(exercise, index)['icon'],
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                getValue(exercise, index)['text'],
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
