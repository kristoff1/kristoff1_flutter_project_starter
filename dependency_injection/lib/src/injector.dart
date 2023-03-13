import 'package:kiwi/kiwi.dart';

import 'dart:developer' as developer;

///FOR KIWI
class Injector {
  ///THIS IS THE SINGLETON KIWI CONTAINER
  ///THE CONTAINER CONTAINS ACCESS TO ALL DEPENDENCIES
  ///THE CONTAINER IS ALSO A PLACE TO REGISTER NEW DEPENDENCIES
  final KiwiContainer _container = KiwiContainer();

  Injector._internal();

  static final Injector _instance = Injector._internal();

  static Injector get instance => _instance;

  ///THIS METHOD IS TO REGISTER SINGLETON
  ///PROBABLY FOR DATABASE
  void registerSingleton<T>(T instance) {
    developer.log('Singleton Registered ${instance.runtimeType.toString()}');
    _container.registerSingleton((_) => instance);
  }

  ///THIS METHOD IS TO REGISTER A DEPENDENCIES WITHOUT ARGUMENTS
  ///FACTORY REGISTRATION MAKES SURE THE METHOD CALLED EVERYTIME THE DEPENDENCY CALLED
  ///THEREFORE THE METHOD WILL RETURN DIFFERENT INSTANCE EVERYTIME
  void registerDependency<T>(Function dependency) {
    _container.registerFactory<T>(
          (container) => dependency(),
    );
  }

  ///THIS METHOD IS TO REGISTER A DEPENDENCIES WITH ONE ARGUMENT
  ///FACTORY REGISTRATION MAKES SURE THE METHOD CALLED EVERYTIME THE DEPENDENCY CALLED
  ///THEREFORE THE METHOD WILL RETURN DIFFERENT INSTANCE EVERYTIME
  void registerDependencyWithOneArg<Dependency, T>(
      Function(Dependency arg) dependency,
      ) {
    _container
        .registerFactory<T>((container) => dependency(container.resolve<Dependency>()));
  }

  ///THIS METHOD IS TO REGISTER A DEPENDENCIES WITH TWO ARGUMENTS
  ///FACTORY REGISTRATION MAKES SURE THE METHOD CALLED EVERYTIME THE DEPENDENCY CALLED
  ///THEREFORE THE METHOD WILL RETURN DIFFERENT INSTANCE EVERYTIME
  void registerDependencyWithTwoArgs<R, S, T>(
      Function(R firstArgument, S secondArgument) dependency,
      ) {
    _container.registerFactory<T>((container) =>
        dependency(container.resolve<R>(), container.resolve<S>()));
  }

  ///CREATE NEW METHOD IF MORE THAN TWO ARGUMENTS NEEDED


  ///THIS METHOD IS TO GET DEPENDENCIES
  ///THE METHOD IS SMART ENOUGH TO RETURN WHICH TYPE TO RETURN
  T getDependencies<T>() {
    return _container.resolve();
  }

}