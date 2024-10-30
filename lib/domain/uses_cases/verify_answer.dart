import 'package:da_movie_quiz/core/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/quiz.dart';
import '../repositories/movie_repository.dart';

class VerifyAnswer {
  final MovieRepository repository;

  VerifyAnswer(this.repository);

  Future<Either<Failure, bool>> call(Quiz quiz, bool answer) async {
    final result = await repository.verifyAnswer(quiz, answer);
    return result;
  }
}
