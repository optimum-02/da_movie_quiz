import 'dart:convert';

import '../../domain/entities/entities.dart';

class MovieDTO {
  final int id;
  final String title;
  final String posterPath;

  MovieDTO({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory MovieDTO.fromJson(Map<String, dynamic> json) {
    return MovieDTO(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }

  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
