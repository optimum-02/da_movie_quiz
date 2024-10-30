import 'dart:convert';
import 'package:da_movie_quiz/core/custom_http_client.dart';
import 'package:da_movie_quiz/core/failures.dart';

import '../dtos/dtos.dart';

final class MovieDBApi {
  final ApiClient httpClient;

  const MovieDBApi(this.httpClient);

  Future<MovieActorDTO> getRandomActor() async {
    final response =
        await httpClient.get('/person/popular?language=en-US&page=1');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final randomActor = ((data['results'] as List)..shuffle()).first;
      return MovieActorDTO.fromJson(randomActor);
    } else {
      throw ServerFailure();
    }
  }

  Future<MovieDTO> getRandomMovie() async {
    final response =
        await httpClient.get('/movie/popular?language=en-US&page=1');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final randomMovie = (data['results']..shuffle()).first;
      return MovieDTO.fromJson(randomMovie);
    } else {
      throw ServerFailure();
    }
  }

  Future<MovieDTO> getRandomMovieWithActor(int actorId) async {
    final response = await httpClient.get('/person/$actorId/movie_credits');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final randomMovie = (data['cast']..shuffle()).first;
      return MovieDTO.fromJson(randomMovie);
    } else {
      throw ServerFailure();
    }
  }

  Future<MovieDTO> getRandomMovieExcludingActor(int actorId) async {
    MovieDTO randomMovie;
    do {
      randomMovie = await getRandomMovie();
    } while (await checkActorInMovie(actorId, randomMovie.id));

    return randomMovie;
  }

  Future<bool> checkActorInMovie(int actorId, int movieId) async {
    final response = await httpClient.get('/movie/$movieId/credits');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cast = data['cast'] as List;
      return cast.any((member) => member['id'] == actorId);
    } else {
      throw ServerFailure();
    }
  }
}
