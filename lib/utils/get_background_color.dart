import 'package:flutter/material.dart';

import '../models/workout.dart';

getBackgroundColor({WorkoutState workout}) {
  switch (workout) {
    case WorkoutState.initial:
    case WorkoutState.starting:
      return Colors.grey[100];
    case WorkoutState.resting:
      return Colors.blue[100];
    case WorkoutState.exercising:
      // return Colors.green[300];
      return Color(0XFFB9FE5E);
    case WorkoutState.breaking:
      return Colors.yellow[400];
    case WorkoutState.coolDown:
      return Colors.teal[400];
    default:
      return Colors.white;
  }
}
