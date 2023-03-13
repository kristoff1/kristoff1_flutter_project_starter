class CountException implements Exception {
  final String message;

  CountException(this.message);

  @override
  String toString() => message;
}
