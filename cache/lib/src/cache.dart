import 'package:shared_preferences/shared_preferences.dart';

///EXAMPLE OF SHARED PREFERENCES

class Cache {
  late final SharedPreferences _sharedPreferences;
  
  Future<void> configureCache() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool getIsFirstTime() {
    return _sharedPreferences.getBool('first_time') ?? true;
  }

  void showAppOpenedOnce() {
    _sharedPreferences.setBool('first_time', false);
  }

  bool getShowOnBoarding() {
    return _sharedPreferences.getBool('show_onboarding') ?? true;
  }

  void setOnBoardingShown() {
    _sharedPreferences.setBool('show_onboarding', false);
  }
  
}