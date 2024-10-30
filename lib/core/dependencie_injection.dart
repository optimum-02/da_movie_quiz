import 'package:da_movie_quiz/core/constants.dart';
import 'package:da_movie_quiz/core/custom_http_client.dart';
import 'package:da_movie_quiz/data/datasource/moviedb_api.dart';
import 'package:da_movie_quiz/data/repository_impl/movie_repository_impl.dart';
import 'package:da_movie_quiz/domain/repositories/repositories.dart';
import 'package:da_movie_quiz/domain/uses_cases/uses_cases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.instance;

void setup() async {
  // await SharedPreferences.getInstance();
  di.registerSingleton(Client());
  di.registerSingleton<ApiClient>(
      ApiClient(client: di.get(), baseUrl: tmdbBaseUrl, apiKey: apiKey));
  di.registerSingleton<MovieDBApi>(MovieDBApi(di.get()));
  di.registerSingleton<MovieRepository>(MovieRepositoryImpl(di.get()));
  di.registerSingleton<GetRandomQuiz>(GetRandomQuiz(di.get()));
  di.registerSingleton<VerifyAnswer>(VerifyAnswer(di.get()));
}
