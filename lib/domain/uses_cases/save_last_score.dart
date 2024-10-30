import 'package:da_movie_quiz/domain/repositories/repositories.dart';

class SaveLastScore {
  final ScoreRepository repository;

  SaveLastScore(this.repository);

  Future<void> call(int score) async {
    await repository.saveLastScore(score);
  }
}
