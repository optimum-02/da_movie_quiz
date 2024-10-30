import 'movie.dart';

class MovieActor {
  final int id;
  final String name;
  final String profilePath;
  final List<Movie> movies;

  MovieActor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.movies,
  });
}
