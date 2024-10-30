import 'package:da_movie_quiz/domain/repositories/repositories.dart';

class SaveHightScore {
  final ScoreRepository repository;

  SaveHightScore(this.repository);

  Future<void> call(int score) async {
    await repository.savehightScore(score);
  }
}
