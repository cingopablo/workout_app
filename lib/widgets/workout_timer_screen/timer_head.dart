import 'package:flutter/material.dart';

import '../../models/workout.dart';
import '../../utils/step_name.dart';
import '../../utils/format_time.dart';
import '../../utils/get_background_color.dart';

class TimerHead extends StatelessWidget {
  const TimerHead({
    Key key,
    @required Workout workout,
  })  : _workout = workout,
        super(key: key);

  final Workout _workout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.black),
        ),
        color: getBackgroundColor(workout: _workout.step),
      ),
      padding: const EdgeInsets.only(
        top: 25,
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Column(
        children: <Widget>[
          Text(
            stepName(_workout.step),
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.black),
          ),
          Text(
            formatTime(
              duration: _workout.timeLeft ?? _workout.config.getStartDelay(),
            ),
            style: Theme.of(context).textTheme.headline3.copyWith(
                  fontSize: 100,
                  height: 1.2,
                  color: Colors.black,
                ),
          ),
          Text(
            '${formatTime(duration: formatTime(duration: _workout.totalTime) == '00:00' ? _workout.config.getTotalTime() : _workout.totalTime)}',
            style: Theme.of(context).textTheme.headline3.copyWith(
                  height: 0.75,
                  color: Colors.black,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'SET ${_workout.set} / ${_workout.config.sets}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'REP ${_workout.rep} / ${_workout.config.repetitions}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
