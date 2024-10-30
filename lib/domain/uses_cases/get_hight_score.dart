import 'package:da_movie_quiz/domain/repositories/repositories.dart';

class GetHightScore {
  final ScoreRepository repository;

  GetHightScore(this.repository);

  Future<int?> call() async {
    return await repository.hightScore();
  }
}
