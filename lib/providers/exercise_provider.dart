import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../helpers/db_helper.dart';
import '../models/exercise.dart';

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

class ExerciseProvider with ChangeNotifier {
  final uuid = Uuid();
  List<Exercise> _items = [];

  List<Exercise> get items {
    return [..._items];
  }

  Exercise findById(String id) {
    return _items.firstWhere((exercise) => exercise.id == id);
  }

  Future<void> addExercise({
    String id,
    String title,
    String createdAt,
    int sets,
    int repetitions,
    Duration exerciseTime,
    Duration restTime,
    Duration breakTime,
  }) async {
    final newExercise = Exercise(
      id: id,
      title: title,
      createdAt: DateTime.now().toIso8601String(),
      sets: sets,
      repetitions: repetitions,
      exerciseTime: exerciseTime,
      restTime: restTime,
      breakTime: breakTime,
    );

    _items.add(newExercise);
    notifyListeners();
    DBHelper.insert('user_exercises', {
      'id': newExercise.id,
      'title': newExercise.title,
      'created_at': newExercise.createdAt,
      'sets': newExercise.sets,
      'repetitions': newExercise.repetitions,
      'exercise_time': newExercise.exerciseTime.toString(),
      'rest_time': newExercise.restTime.toString(),
      'break_time': newExercise.breakTime.toString(),
    });
  }

  Future<void> deleteExercise(String exerciseId) async {
    _items.removeWhere((exercise) => exercise.id == exerciseId);
    DBHelper.remove('user_exercises', exerciseId);
    notifyListeners();
  }

  Future<void> fetchAndSetExercises() async {
    final dataList = await DBHelper.getData('user_exercises');
    _items = dataList
        .map(
          (item) => Exercise(
            id: item['id'],
            title: item['title'],
            createdAt: item['created_at'],
            sets: item['sets'],
            repetitions: item['repetitions'],
            exerciseTime: parseDuration(item['exercise_time']),
            restTime: parseDuration(item['rest_time']),
            breakTime: parseDuration(item['break_time']),
          ),
        )
        .toList();
    print(dataList);
    notifyListeners();
  }
}
