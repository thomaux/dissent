enum GamePhase {
  start,
  first,
  half,
  second,
  full,
}

enum PhaseTransitionType {
  start,
  stop,
  reset,
}

class PhaseTransition {
  final GamePhase target;
  final PhaseTransitionType type;
  const PhaseTransition({required this.target, required this.type});
}

Map<GamePhase, PhaseTransition> transitions = {
  GamePhase.start: const PhaseTransition(
      target: GamePhase.first, type: PhaseTransitionType.start),
  GamePhase.first: const PhaseTransition(
      target: GamePhase.half, type: PhaseTransitionType.stop),
  GamePhase.half: const PhaseTransition(
      target: GamePhase.second, type: PhaseTransitionType.start),
  GamePhase.second: const PhaseTransition(
      target: GamePhase.full, type: PhaseTransitionType.stop),
  GamePhase.full: const PhaseTransition(
      target: GamePhase.start, type: PhaseTransitionType.reset),
};