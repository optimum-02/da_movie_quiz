import 'package:da_movie_quiz/core/failures.dart';
import 'package:da_movie_quiz/domain/uses_cases/uses_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetRandomQuiz getRandomQuiz;
  Timer? _roundTimer;
  int _currentScore = 0;

  GameBloc({
    required this.getRandomQuiz,
  }) : super(GameInitial()) {
    on<GameStarted>(_onGameStarted);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<TimerTick>(_onTimerTick);
    on<GameEnded>(_onGameEnded);
    on<NewRoundLoaded>(_onNewRoundLoaded);
  }

  Future<void> _onGameStarted(
      GameStarted event, Emitter<GameState> emit) async {
    await _loadNewRound(emit);
  }

  Future<void> _onAnswerQuestion(
      AnswerQuestion event, Emitter<GameState> emit) async {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;

      if (event.answer == currentState.currentQuiz!.correctAnswer) {
        // Bonne réponse
        _currentScore += 10;
        emit(currentState.copyWith(score: _currentScore));
        await _loadNewRound(emit);
      } else {
        // Mauvaise réponse
        await _endGame(emit);
      }
    }
  }

  void _onTimerTick(TimerTick event, Emitter<GameState> emit) {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;
      if (currentState.timeLeft > 0) {
        emit(currentState.copyWith(timeLeft: currentState.timeLeft - 1));
      } else {
        _endGame(emit);
      }
    }
  }

  Future<void> _onGameEnded(GameEnded event, Emitter<GameState> emit) async {
    await _endGame(emit);
  }

  Future<void> _onNewRoundLoaded(
      NewRoundLoaded event, Emitter<GameState> emit) async {
    await _loadNewRound(emit);
  }

  void _startTimer() {
    _roundTimer?.cancel();
    _roundTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => add(TimerTick()),
    );
  }

  Future<void> _loadNewRound(Emitter<GameState> emit) async {
    emit(RoundLoading());

    final failureOrQuiz = await getRandomQuiz();

    failureOrQuiz.match(
      (failure) {
        emit(GameError(failure));
      },
      (quiz) {
        emit(GameInProgress(
            currentQuiz: quiz, timeLeft: 600, score: _currentScore));
      },
    );
  }

  Future<void> _endGame(Emitter<GameState> emit) async {
    _roundTimer?.cancel();
    // await scoreService.saveScore(currentState.score);
    emit(GameOver(_currentScore));
    _currentScore = 0;
  }

  @override
  Future<void> close() {
    _roundTimer?.cancel();
    return super.close();
  }
}
