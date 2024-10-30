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
  final bool roundLoading;
  const GameInProgress(
      {required this.timeLeft,
      required this.score,
      this.currentQuiz,
      required this.roundLoading});

  @override
  List<Object?> get props => [timeLeft, score, currentQuiz, roundLoading];

  GameInProgress copyWith({
    int? timeLeft,
    int? score,
    Quiz? currentQuiz,
    bool? roundLoading,
  }) {
    return GameInProgress(
      timeLeft: timeLeft ?? this.timeLeft,
      score: score ?? this.score,
      currentQuiz: currentQuiz ?? this.currentQuiz,
      roundLoading: roundLoading ?? this.roundLoading,
    );
  }
}

class GameOver extends GameState {
  final int finalScore;
  final int hightScore;

  const GameOver(this.finalScore, this.hightScore);

  @override
  List<Object> get props => [finalScore, hightScore];
}

class GameError extends GameState {
  final Failure failure;

  const GameError(this.failure);

  @override
  List<Object> get props => [failure];
}
