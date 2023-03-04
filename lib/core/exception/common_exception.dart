class ResponseException implements Exception {}

class ServerException implements ResponseException {
  ServerException() : super();
}

class AuthorizationException implements ResponseException {
  AuthorizationException() : super();
}

class ResponseDataParsingException implements ResponseException {
  ResponseDataParsingException() : super();
}

class DataParsingException implements Exception {
  DataParsingException() : super();
}
