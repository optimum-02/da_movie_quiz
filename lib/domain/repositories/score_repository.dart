abstract interface class ScoreRepository {
  Future<void> saveLastScore(int score);
  Future<void> savehightScore(int score);
  Future<int?> lastScore();
  Future<int?> hightScore();
}
