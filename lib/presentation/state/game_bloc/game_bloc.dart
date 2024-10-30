import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:da_movie_quiz/core/failures.dart';
import 'package:da_movie_quiz/domain/uses_cases/uses_cases.dart';

import '../../../domain/entities/entities.dart';

part 'game_event.dart';
part 'game_state.dart';

const gameMaxTimeInSecond = 60;

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetRandomQuiz getRandomQuiz;
  final SaveHightScore saveHightScore;
  final SaveLastScore saveLastScore;
  final GetLastScore getLastScore;
  final GetHightScore getHightScore;

  Timer? _roundTimer;
  int _currentScore = 0;
  int _timeLeft = gameMaxTimeInSecond;

  GameBloc({
    required this.getRandomQuiz,
    required this.saveHightScore,
    required this.saveLastScore,
    required this.getLastScore,
    required this.getHightScore,
  }) : super(GameInitial()) {
    on<GameStarted>(_onGameStarted);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<TimerTick>(_onTimerTick);
    on<GameEnded>(_onGameEnded);
    on<NewRoundLoaded>(_onNewRoundLoaded);
  }

  Future<void> _onGameStarted(
      GameStarted event, Emitter<GameState> emit) async {
    emit(RoundLoading());
    await _loadNewRound(emit);
    _startTimer();
  }

  Future<void> _onAnswerQuestion(
      AnswerQuestion event, Emitter<GameState> emit) async {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;

      if (event.answer == currentState.currentQuiz!.correctAnswer) {
        // Bonne réponse
        _currentScore += 1;
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
        _timeLeft -= 1;
        emit(currentState.copyWith(timeLeft: _timeLeft));
      } else {
        add(GameEnded());
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
    emit(GameInProgress(
        roundLoading: true, timeLeft: _timeLeft, score: _currentScore));
    final failureOrQuiz = await getRandomQuiz();

    failureOrQuiz.match(
      (failure) {
        emit(GameError(failure));
      },
      (quiz) {
        emit((state as GameInProgress).copyWith(
            roundLoading: false, currentQuiz: quiz, score: _currentScore));
      },
    );
  }

  Future<void> _endGame(Emitter<GameState> emit) async {
    _roundTimer?.cancel();
    await saveLastScore(_currentScore);
    int? hightScore = await getHightScore();
    if ((hightScore ?? 0) < _currentScore) {
      saveHightScore(_currentScore);
      hightScore = _currentScore;
    }

    emit(GameOver(_currentScore, hightScore ?? 0));
    _currentScore = 0;
    _timeLeft = gameMaxTimeInSecond;
  }

  @override
  Future<void> close() {
    _roundTimer?.cancel();
    return super.close();
  }
}
