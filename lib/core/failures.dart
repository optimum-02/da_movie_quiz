abstract interface class Failure {}

class ServerFailure extends Failure {}

class NoInternetConnexion extends Failure {}

class UnexpectedFailure extends Failure {
  final dynamic error;

  UnexpectedFailure(this.error);
}
