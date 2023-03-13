class UninitiatedException implements Exception {
  final String message;

  UninitiatedException(this.message);

  @override
  String toString() => message;
}
