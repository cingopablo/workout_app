import 'dart:async';
import 'dart:core';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

import './exercise.dart';
import './settings.dart';

var player = AudioCache(prefix: 'sounds/');

enum WorkoutState {
  initial,
  starting,
  exercising,
  resting,
  breaking,
  coolDown,
  finished,
}

class Workout {
  Settings _settings;
  Exercise _config;

  /// Callback for when the workout's state has changed.
  Function _onStateChange;

  WorkoutState _step = WorkoutState.initial;

  Timer _timer;

  /// Time left in the current step
  Duration _timeLeft; // = Duration(seconds: 0);
  // Duration _timeLeft;

  var _totalTime = Duration(seconds: 0);

  /// Current set
  int _set = 0;

  /// Current rep
  int _rep = 0;

  int _current = 0;

  Workout(
    this._settings,
    this._config,
    this._onStateChange,
  );

  /// Starts or resumes the workout
  start() {
    if (_step == WorkoutState.initial) {
      _totalTime = _config.getTotalTime();
      _step = WorkoutState.starting;
      if (_config.startDelay.inSeconds == 0) {
        _nextStep();
      } else {
        _timeLeft = _config.startDelay;
      }
    }
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
    _onStateChange();
  }

  /// Pauses the workout
  pause() {
    _timer.cancel();
    _onStateChange();
  }

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
    } else if (_step == WorkoutState.starting ||
        _step == WorkoutState.breaking ||
        _step == WorkoutState.resting) {
      return 'Exercise';
    } else if (_step == WorkoutState.coolDown) {
      return 'Finish';
    }
  }

  getAllSteps() {
    List<Map<String, dynamic>> steps = [
      {
        'title': 'Get ready',
        'value': _config.startDelay,
        'step': WorkoutState.initial
      }
    ];

    for (var i = 1; i <= _config.sets; i++) {
      for (var j = 1; j <= _config.repetitions; j++) {
        steps.add({
          'title': 'Exercise',
          'value': _config.exerciseTime,
          'step': WorkoutState.exercising
        });
        if (j != _config.repetitions) {
          steps.add({
            'title': 'Rest',
            'value': _config.restTime,
            'step': WorkoutState.resting
          });
        }
        if (j == _config.repetitions) {
          steps.add({
            'title': 'Break',
            'value': _config.breakTime,
            'step': WorkoutState.breaking
          });
        }
      }
    }

    if (steps[steps.length - 1]['title'] == 'Rest' ||
        steps[steps.length - 1]['title'] == 'Break') {
      steps.removeLast();
    }

    steps.add({
      'title': 'Cool down',
      'value': _config.coolDownTime,
      'step': WorkoutState.coolDown
    });
    return steps;
  }

  /// Stops the timer without triggering the state change callback.
  dispose() {
    _timer.cancel();
  }

  _tick(Timer timer) {
    if (_step != WorkoutState.starting) {
      _totalTime -= Duration(seconds: 1);
    }

    if (_timeLeft.inSeconds == 1) {
      _nextStep();
    } else {
      _timeLeft -= Duration(seconds: 1);
      if (_timeLeft.inSeconds <= 3 && _timeLeft.inSeconds >= 1) {
        _playSound(_settings.countdownPip);
      }
    }

    _onStateChange();
  }

  /// Moves the workout to the next step and sets up state for it.
  _nextStep() {
    _current++;
    if (_step == WorkoutState.exercising) {
      if (rep == _config.repetitions) {
        if (set == _config.sets) {
          _coolDown();
        } else {
          _startBreak();
        }
      } else {
        _startRest();
      }
    } else if (_step == WorkoutState.resting) {
      _startRep();
    } else if (_step == WorkoutState.starting ||
        _step == WorkoutState.breaking) {
      _startSet();
    } else if (_step == WorkoutState.coolDown) {
      _finish();
    }
  }

  Future _playSound(String sound) {
    // if (_settings.silentMode) {
    //   return Future.value();
    // }
    return player.play(sound);
  }

  _startRest() {
    _step = WorkoutState.resting;
    if (_config.restTime.inSeconds == 0) {
      _nextStep();
      return;
    }
    _timeLeft = _config.restTime;
    _playSound(_settings.startRest);
  }

  _startRep() {
    _rep++;
    _step = WorkoutState.exercising;
    _timeLeft = _config.exerciseTime;
    _playSound(_settings.startRep);
  }

  _startBreak() {
    _step = WorkoutState.breaking;
    if (_config.breakTime.inSeconds == 0) {
      _nextStep();
      return;
    }
    _timeLeft = _config.breakTime;
    _playSound(_settings.startBreak);
  }

  _startSet() {
    _set++;
    _rep = 1;
    _step = WorkoutState.exercising;
    _timeLeft = _config.exerciseTime;
    _playSound(_settings.startSet);
  }

  _coolDown() {
    _step = WorkoutState.coolDown;
    _timeLeft = _config.coolDownTime;
    _playSound(_settings.startBreak);
  }

  _finish() {
    _timer.cancel();
    _step = WorkoutState.finished;
    _timeLeft = Duration(seconds: 0);
    _playSound(_settings.endWorkout).then((p) {
      if (p == null) {
        return;
      }
      p.onPlayerCompletion.first.then((_) {
        _playSound(_settings.endWorkout);
      });
    });
  }

  get config => _config;

  get set => _set;

  get rep => _rep;

  get step => _step;

  get timeLeft => _timeLeft;

  get current => _current;

  get totalTime => _totalTime;

  get isActive => _timer != null && _timer.isActive;
}
