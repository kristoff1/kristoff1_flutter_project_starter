import 'package:dependency_injection/dependency_injection.dart';

import '../cache.dart';

///ONLY IF YOU'RE GOING TO USE DI PACKAGE
///DELETE IF NOT
class CacheInitiator {
  final Injector _injector = Injector.instance;

  void initiateSharedPreference() {
    _injector.registerSingleton<Cache>(Cache());
  }
}