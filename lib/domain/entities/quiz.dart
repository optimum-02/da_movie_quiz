import 'movie.dart';
import 'movie_actor.dart';

class Quiz {
  final MovieActor actor;
  final Movie movie;
  final bool correctAnswer;

  Quiz({
    required this.actor,
    required this.movie,
    required this.correctAnswer,
  });
}
