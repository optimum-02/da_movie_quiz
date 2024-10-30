abstract interface class Failure {
  String toMessage();
}

class ServerFailure extends Failure {
  @override
  String toMessage() {
    return "Server error. Please try again later";
  }
}

class NoInternetConnexion extends Failure {
  @override
  String toMessage() {
    return "No internet connexion. Check and retry";
  }
}

class UnexpectedFailure extends Failure {
  final dynamic error;

  UnexpectedFailure(this.error);

  @override
  String toMessage() {
    return "An unexpected error occured ! Please try later";
  }
}
