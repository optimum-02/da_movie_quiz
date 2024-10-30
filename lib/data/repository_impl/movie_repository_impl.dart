import 'dart:math';

import 'package:da_movie_quiz/core/failures.dart';
import 'package:da_movie_quiz/data/datasource/moviedb_api.dart';
import 'package:da_movie_quiz/data/dtos/dtos.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/quiz.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDBApi movieDbApi;

  MovieRepositoryImpl(this.movieDbApi);

  @override
  Future<Either<Failure, Quiz>> getRandomQuiz() async {
    try {
      final actor = await movieDbApi.getRandomActor();
      bool actorMustActInMovie = Random().nextBool();

      MovieDTO movie;
      if (actorMustActInMovie) {
        movie = await movieDbApi.getRandomMovieWithActor(actor.id);
      } else {
        movie = await movieDbApi.getRandomMovieExcludingActor(actor.id);
      }

      return Right(
        Quiz(
          actor: actor.toMovieActor(),
          movie: movie.toMovie(),
          correctAnswer: actorMustActInMovie,
        ),
      );
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(UnexpectedFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyAnswer(Quiz quiz, bool answer) async {
    return Right(quiz.correctAnswer == answer);
  }
}
