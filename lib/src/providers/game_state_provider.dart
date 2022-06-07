import 'dart:async';

import 'package:flutter/material.dart';

import '../models/game_phase.dart';

class GameStateProvider extends ChangeNotifier {
  final int _secondsPerHalf = 5;
  GamePhase _phase = GamePhase.start;
  Timer? _timer;
  int _seconds = 0;

  void nextPhase() {
    PhaseTransition transition = transitions[_phase]!;

    switch (transition.type) {
      case PhaseTransitionType.start:
        _start();
        break;
      case PhaseTransitionType.stop:
        _stop();
        break;
      case PhaseTransitionType.reset:
        reset();
        return;
    }

    _phase = transition.target;
    notifyListeners();
  }

  void reset() {
    _phase = GamePhase.start;
    _seconds = 0;
    _stop();
    notifyListeners();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      if (_seconds % _secondsPerHalf == 0) {
        nextPhase();
      } else {
        notifyListeners();
      }
    });
  }

  void _stop() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  GamePhase get phase {
    return _phase;
  }

  int get seconds {
    return _seconds;
  }
}
