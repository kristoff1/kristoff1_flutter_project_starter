class MigratingException implements Exception {
  final String message;

  MigratingException(this.message);

  @override
  String toString() => message;
}
