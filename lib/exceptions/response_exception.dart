/// This class is just a generic exception class for
/// request/response related issues.
class ResponseException implements Exception {
  String cause;

  ResponseException({required this.cause});

  String getCause() {
    return cause;
  }
}
