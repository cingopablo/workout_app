import 'package:flutter/material.dart';

import '../models/workout.dart';

getBackgroundColor({
  Workout workout,
  BuildContext context,
}) {
  switch (workout.step) {
    case WorkoutState.initial:
    case WorkoutState.starting:

    case WorkoutState.exercising:
    case WorkoutState.resting:
    case WorkoutState.coolDown:
      return Colors.blue[100];
    case WorkoutState.breaking:
      return Colors.red[100];
    default:
      return Theme.of(context).backgroundColor;
  }
}
