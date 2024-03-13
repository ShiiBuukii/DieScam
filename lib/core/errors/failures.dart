abstract class Failure {
  final String? failMessage;

  Failure(this.failMessage);
}

class RequestFailure extends Failure {
  RequestFailure(super.failMessage);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.failMessage);
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.failMessage);
}
