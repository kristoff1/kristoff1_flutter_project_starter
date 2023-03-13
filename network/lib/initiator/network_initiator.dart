import 'package:dependency_injection/dependency_injection.dart';
import 'package:network/adapter/network_implementation.dart';

class NetworkInitiator {
  final Injector _injector = Injector.instance;

  void initiateNetwork() {
    _injector.registerSingleton(NetworkImplementation());
  }
}