part of 'game_bloc.dart';

sealed class GameEvent {}

class GameStarted extends GameEvent {}

class AnswerQuestion extends GameEvent {
  final bool answer;
  AnswerQuestion(this.answer);
}

class TimerTick extends GameEvent {}

class GameEnded extends GameEvent {}

class NewRoundLoaded extends GameEvent {}
