import 'dart:convert';

import '../../domain/entities/entities.dart';

class MovieActorDTO {
  final int id;
  final String name;
  final String profilePath;

  MovieActorDTO({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory MovieActorDTO.fromJson(Map<String, dynamic> json) {
    return MovieActorDTO(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
    );
  }

  MovieActor toMovieActor() {
    return MovieActor(
      id: id,
      name: name,
      profilePath: profilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
