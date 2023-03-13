import 'package:database/src/database_implementation.dart';
import 'package:dependency_injection/dependency_injection.dart';
import '../database_interface.dart';

///ONLY IF YOU'RE GOING TO USE DI PACKAGE
///DELETE IF NOT
class DatabaseInitiator {
  final Injector _injector = Injector.instance;

  void initiateDatabase() {
    _injector.registerSingleton<DatabaseInterface>(DatabaseImplementation());
  }
}
