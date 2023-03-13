class DeleteException implements Exception {
  final String message;
  const DeleteException(this.message);
  @override
  String toString() => "Delete Exception: $message";
}
