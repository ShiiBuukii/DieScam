class RequestException implements Exception {
  final String? message;

  RequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String? message;

  UnauthorizedException({required this.message});
}

class BadRequestException implements Exception {
  final String? message;

  BadRequestException({required this.message});
}
