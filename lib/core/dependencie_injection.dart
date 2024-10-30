import 'package:da_movie_quiz/core/constants.dart';
import 'package:da_movie_quiz/core/custom_http_client.dart';
import 'package:da_movie_quiz/data/datasource/datasource.dart';
import 'package:da_movie_quiz/data/repository_impl/repository_impl.dart';
import 'package:da_movie_quiz/domain/repositories/repositories.dart';
import 'package:da_movie_quiz/domain/uses_cases/uses_cases.dart';
import 'package:da_movie_quiz/presentation/state/game_bloc/game_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final GetIt di = GetIt.instance;

void setupDependenciesInjection() {
  di.registerSingleton(Client());
  di.registerSingleton<ApiClient>(
      ApiClient(client: di.get(), baseUrl: tmdbApiBaseUrl, apiKey: tmdbApiKey));
  di.registerSingleton(const FlutterSecureStorage());
  di.registerSingleton<MovieDBApi>(MovieDBApi(di.get()));
  di.registerSingleton<ScoreDataSource>(ScoreDataSource(di.get()));
  di.registerSingleton<MovieRepository>(MovieRepositoryImpl(di.get()));
  di.registerSingleton<ScoreRepository>(ScoreRepositoryImpl(di.get()));
  di.registerSingleton<GetRandomQuiz>(GetRandomQuiz(di.get()));
  di.registerSingleton<VerifyAnswer>(VerifyAnswer(di.get()));
  di.registerSingleton<SaveHightScore>(SaveHightScore(di.get()));
  di.registerSingleton<GetHightScore>(GetHightScore(di.get()));
  di.registerSingleton<SaveLastScore>(SaveLastScore(di.get()));
  di.registerSingleton<GetLastScore>(GetLastScore(di.get()));
  di.registerFactory<GameBloc>(
    () => GameBloc(
      getHightScore: di.get(),
      getLastScore: di.get(),
      getRandomQuiz: di.get(),
      saveHightScore: di.get(),
      saveLastScore: di.get(),
    ),
  );
}
