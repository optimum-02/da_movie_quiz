part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class RoundLoading extends GameState {}

class GameInProgress extends GameState {
  final int timeLeft;
  final int score;
  final Quiz? currentQuiz;
  const GameInProgress({
    required this.timeLeft,
    required this.score,
    this.currentQuiz,
  });

  @override
  List<Object?> get props => [timeLeft, score, currentQuiz];

  GameInProgress copyWith({
    int? timeLeft,
    int? score,
    Quiz? currentQuiz,
  }) {
    return GameInProgress(
      timeLeft: timeLeft ?? this.timeLeft,
      score: score ?? this.score,
      currentQuiz: currentQuiz ?? this.currentQuiz,
    );
  }
}

class GameOver extends GameState {
  final int finalScore;

  const GameOver(this.finalScore);

  @override
  List<Object> get props => [finalScore];
}

class GameError extends GameState {
  final Failure failure;

  const GameError(this.failure);

  @override
  List<Object> get props => [failure];
}
