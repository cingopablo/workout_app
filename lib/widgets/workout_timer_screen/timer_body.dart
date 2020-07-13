import 'package:flutter/material.dart';

import '../../models/workout.dart';
import '../../utils/format_time.dart';
import '../../utils/get_background_color.dart';

class TimerBody extends StatelessWidget {
  final ScrollController controller;
  final double height;

  const TimerBody({
    Key key,
    @required Workout workout,
    this.controller,
    this.height,
  })  : _workout = workout,
        super(key: key);

  final Workout _workout;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: _workout.getAllSteps().length,
        itemBuilder: (ctx, index) => Container(
          //margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          height: height,
          // padding: const EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: getBackgroundColor(
              workout: _workout.getAllSteps()[index]['step'],
            ),
            //borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_workout.getAllSteps()[index]['title']} ${formatTime(duration: _workout.getAllSteps()[index]['value'])}',
            style: _workout.current == index
                ? Theme.of(context).textTheme.headline2
                : Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
