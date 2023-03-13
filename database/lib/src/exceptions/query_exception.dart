class QueryException implements Exception {
  final String message;

  QueryException(this.message);

  @override
  String toString() => message;
}
