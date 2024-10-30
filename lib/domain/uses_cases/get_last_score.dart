import 'package:da_movie_quiz/domain/repositories/repositories.dart';

class GetLastScore {
  final ScoreRepository repository;

  GetLastScore(this.repository);

  Future<int?> call() async {
    return await repository.lastScore();
  }
}
