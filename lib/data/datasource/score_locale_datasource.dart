import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class ScoreDataSource {
  final FlutterSecureStorage secureStorage;

  ScoreDataSource(this.secureStorage);
  Future<void> saveLastScore(int score) async {
    await secureStorage.write(key: "lastScore", value: "$score");
  }

  Future<void> saveHightScore(int hightScore) async {
    await secureStorage.write(key: "hightScore", value: "$hightScore");
  }

  Future<int?> hightScore() async {
    final value = await secureStorage.read(key: "hightScore");
    return int.tryParse(value ?? "");
  }

  Future<int?> lastScore() async {
    final value = await secureStorage.read(key: "lastScore");
    return int.tryParse(value ?? "");
  }
}
