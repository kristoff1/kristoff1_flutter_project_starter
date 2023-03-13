class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);

  @override
  String toString() => message;
}