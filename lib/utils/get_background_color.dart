import 'package:flutter/material.dart';

import '../models/workout.dart';

getBackgroundColor({WorkoutState workout}) {
  switch (workout) {
    case WorkoutState.initial:
    case WorkoutState.starting:
      return Colors.grey[100];
    case WorkoutState.resting:
      return Color(0XFFa1d3fc);
    case WorkoutState.exercising:
      return Color(0XFF76f799);
    case WorkoutState.breaking:
      return Color(0XFFf7ff58);
    case WorkoutState.coolDown:
      return Color(0XFFee83f5);
    default:
      return Colors.white;
  }
}
