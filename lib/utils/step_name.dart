import '../models/workout.dart';

String stepName(WorkoutState step) {
  switch (step) {
    case WorkoutState.exercising:
      return 'Exercise';
    case WorkoutState.resting:
      return 'Rest';
    case WorkoutState.breaking:
      return 'Break';
    case WorkoutState.finished:
      return 'Finished';
    case WorkoutState.starting:
      return 'Get ready!';
    case WorkoutState.coolDown:
      return 'Cool down!';
    default:
      return 'Get ready!';
  }
}
