//create a wrong format exception class
class WrongFormatException implements Exception {
  final String message;

  WrongFormatException(this.message);

  @override
  String toString() => message;
}
