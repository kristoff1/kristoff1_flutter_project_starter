class NoPermissionException implements Exception {
  final String message;

  NoPermissionException(this.message);

  @override
  String toString() => message;
}
