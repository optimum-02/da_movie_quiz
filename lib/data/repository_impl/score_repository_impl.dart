import 'package:da_movie_quiz/data/datasource/score_locale_datasource.dart';
import 'package:da_movie_quiz/domain/repositories/score_repository.dart';

final class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreDataSource dataSource;

  ScoreRepositoryImpl(this.dataSource);
  @override
  Future<int?> hightScore() async {
    return dataSource.hightScore();
  }

  @override
  Future<int?> lastScore() async {
    return dataSource.lastScore();
  }

  @override
  Future<void> saveLastScore(int score) async {
    await dataSource.saveLastScore(score);
  }

  @override
  Future<void> savehightScore(int score) async {
    await dataSource.saveHightScore(score);
  }
}
