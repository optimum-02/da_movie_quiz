import 'package:shared_preferences/shared_preferences.dart';

final class ScoreDataSource {
  final SharedPreferences sharedPreferences;

  ScoreDataSource(this.sharedPreferences);
  Future<void> saveLastScore(int score) async {
    await sharedPreferences.setInt("lastScore", score);
  }

  Future<void> saveHightScore(int hightScore) async {
    await sharedPreferences.setInt("hightScore", hightScore);
  }

  int? hightScore() {
    return sharedPreferences.getInt("hightScore");
  }

  int? lastScore() {
    return sharedPreferences.getInt("hightScore");
  }
}
