import 'package:flutter/material.dart';

class Exercise {
  /// Sets in a workout
  int sets;

  /// Repetitions in a set
  int repetitions;

  /// Exercise time in each repetition
  Duration exerciseTime;

  /// Rest time between repetitions
  Duration restTime;

  /// Break time between sets
  Duration breakTime;

  /// "Get ready" countdown
  Duration startDelay;

  /// "Cool down" time
  Duration coolDownTime = Duration(seconds: 20);

  Exercise({
    @required this.sets,
    @required this.repetitions,
    this.startDelay = const Duration(seconds: 5),
    @required this.exerciseTime,
    @required this.restTime,
    @required this.breakTime,
    this.coolDownTime = const Duration(seconds: 20),
  });

  Duration getTotalTime() {
    return (exerciseTime * sets * repetitions) +
        (restTime * sets * (repetitions - 1)) +
        (breakTime * (sets - 1)) +
        coolDownTime;
  }

  Duration getStartDelay() {
    return startDelay;
  }

  Duration getExerciseTime() {
    return exerciseTime;
  }

  Duration getRestTime() {
    return restTime;
  }
}
