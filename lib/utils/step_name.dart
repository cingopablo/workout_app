import '../models/workout.dart';

String stepName(WorkoutState step) {
  switch (step) {
    case WorkoutState.exercising:
      return 'EXERCISE';
    case WorkoutState.resting:
      return 'REST';
    case WorkoutState.breaking:
      return 'BREAK';
    case WorkoutState.finished:
      return 'FINISHED';
    case WorkoutState.starting:
      return 'GET READY!';
    case WorkoutState.coolDown:
      return 'COOL DOWN';
    default:
      return 'GET READY!';
  }
}
