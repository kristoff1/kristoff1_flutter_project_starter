class InitiationException implements Exception {
  final String message;
  const InitiationException(this.message);
  @override
  String toString() => "InitiationException: $message";
}
