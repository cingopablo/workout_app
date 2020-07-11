import 'package:flutter/material.dart';

import '../models/workout.dart';

getBackgroundColor({
  Workout workout,
  BuildContext context,
}) {
  switch (workout.step) {
    case WorkoutState.exercising:
      return Colors.green[200];
    case WorkoutState.initial:
    case WorkoutState.starting:
    case WorkoutState.resting:
    case WorkoutState.coolDown:
      return Colors.blue[200];
    case WorkoutState.breaking:
      return Colors.red[200];
    default:
      return Theme.of(context).backgroundColor;
  }
}
