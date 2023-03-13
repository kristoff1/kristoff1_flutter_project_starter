//create an exception class for the need maintenance exception
class NeedUpdateException implements Exception {
  final String message;

  NeedUpdateException(this.message);
}
