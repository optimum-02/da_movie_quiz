import 'package:da_movie_quiz/core/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/quiz.dart';
import '../repositories/movie_repository.dart';

class GetRandomQuiz {
  final MovieRepository repository;

  GetRandomQuiz(this.repository);

  Future<Either<Failure, Quiz>> call() async {
    final quiz = await repository.getRandomQuiz();
    return quiz;
  }
}
