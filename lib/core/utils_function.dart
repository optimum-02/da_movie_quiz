import 'dart:io';

import 'package:da_movie_quiz/core/failures.dart';

Future<T> apiCallWithErrorHandling<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on SocketException {
    throw NoInternetConnexion();
  } catch (e) {
    throw UnexpectedFailure(e);
  }
}
