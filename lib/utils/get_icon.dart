import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/workout.dart';

getIcon({Workout workout}) {
  switch (workout.step) {
    case WorkoutState.initial:
    case WorkoutState.starting:
    case WorkoutState.resting:
    case WorkoutState.breaking:
      return FontAwesomeIcons.running;
    case WorkoutState.exercising:
    case WorkoutState.coolDown:
      return FontAwesomeIcons.couch;
    default:
      return FontAwesomeIcons.times;
  }
}

/*
getNextStep() {
    if (_step == WorkoutState.initial) return 'Exercise';
    if (_step == WorkoutState.exercising) {
      if (rep == _config.repetitions) {
        if (set == _config.sets) {
          return 'Cool down';
        } else {
          return 'Break';
        }
      } else {
        return 'Rest';
      }
    } else if (_step == WorkoutState.resting) {
      return 'Start rep';
    } else if (_step == WorkoutState.starting ||
        _step == WorkoutState.breaking) {
      return 'Exercise';
    } else if (_step == WorkoutState.coolDown) {
      return 'Finish';
    }
  }
  */
