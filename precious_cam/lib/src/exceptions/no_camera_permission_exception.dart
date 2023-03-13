class NoCameraPermissionException implements Exception {
  final String message;

  NoCameraPermissionException(this.message);

  @override
  String toString() => message;
}
