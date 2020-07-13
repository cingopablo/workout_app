import 'package:flutter/material.dart';

import '../../models/workout.dart';
import '../../utils/format_time.dart';
import '../../utils/get_background_color.dart';

class TimerBody extends StatelessWidget {
  const TimerBody({
    Key key,
    @required Workout workout,
  })  : _workout = workout,
        super(key: key);

  final Workout _workout;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _workout.getAllSteps().length,
        itemBuilder: (ctx, index) => Container(
          //margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          // height: 80,
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                ? Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black)
                : Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
