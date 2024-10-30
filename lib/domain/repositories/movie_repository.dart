import 'package:fpdart/fpdart.dart';

import '../../core/failures.dart';
import '../entities/quiz.dart';

abstract class MovieRepository {
  Future<Either<Failure, Quiz>> getRandomQuiz();
  Future<Either<Failure, bool>> verifyAnswer(Quiz quiz, bool answer);
}
