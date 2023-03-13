class UnderMaintenanceException implements Exception {
  final String message;

  UnderMaintenanceException(this.message);

  @override
  String toString() => message;
}