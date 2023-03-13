class UpdateException implements Exception {
  final String message;

  UpdateException(this.message);

  @override
  String toString() => message;
}
