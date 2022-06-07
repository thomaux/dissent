import 'package:dissent/src/models/game_phase.dart';

enum GameEventType { phaseTransition, goal }

class GameEvent {
  final GameEventType type;
  final bool isUndoable;
  final int seconds;
  const GameEvent({
    required this.type,
    required this.isUndoable,
    required this.seconds,
  });
}

class GoalByThemEvent extends GameEvent {
  const GoalByThemEvent(int seconds)
      : super(type: GameEventType.goal, isUndoable: true, seconds: seconds);
}

class GoalByUsEvent extends GameEvent {
  GoalByUsEvent(int seconds)
      : super(type: GameEventType.goal, isUndoable: true, seconds: seconds);
}

class PhaseTransitionEvent extends GameEvent {
  final GamePhase phase;
  const PhaseTransitionEvent({required this.phase, required int seconds})
      : super(
            type: GameEventType.phaseTransition,
            isUndoable: false,
            seconds: seconds);
}
