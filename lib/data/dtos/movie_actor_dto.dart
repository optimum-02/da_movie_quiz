import 'dart:convert';

import '../../domain/entities/entities.dart';
import 'movie_dto.dart';

class MovieActorDTO {
  final int id;
  final String name;
  final String profilePath;
  final List<MovieDTO> movies;

  MovieActorDTO({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.movies,
  });

  factory MovieActorDTO.fromJson(Map<String, dynamic> json) {
    return MovieActorDTO(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      movies: (json['movies'] as List<dynamic>)
          .map((movieJson) => MovieDTO.fromJson(movieJson))
          .toList(),
    );
  }

  MovieActor toMovieActor() {
    return MovieActor(
      id: id,
      name: name,
      profilePath: profilePath,
      movies: movies.map((movieDTO) => movieDTO.toMovie()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
      'movies': movies.map((movieDTO) => movieDTO.toMap()).toList(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
