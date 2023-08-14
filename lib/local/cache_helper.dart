import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getDataFromSharedPreference({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveDataSharedPreference(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }


  static Future clearData(){
    return sharedPreferences.clear();
  }


  static Future<bool> putBoolean ({
    required String key,
    required bool value,
  })async
  {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> setBoolean ({
    required String key,
    required bool value,
  })async
  {
    return await sharedPreferences.setBool(key, value);
  }


  static dynamic getData ({
    required String key,
  })
  {
    return sharedPreferences.get(key);
  }

  static Future<dynamic> saveData ({
    required String key,
    required dynamic value,
  })async
  {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    // lw 7aga 8er keda htro7ll double
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData ({
    required String key,
  })async
  {
    return await sharedPreferences.remove(key);
  }



  Future<void> setSplashScreenViewed() async {
    sharedPreferences.setBool('splash', true);
  }

  Future<bool> isOnSplashScreenViewed() async {
    return sharedPreferences.getBool('splash') ?? false;
  }

  Future<void> setOnBoardingScreenViewed() async {
    sharedPreferences.setBool('onBoarding', true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return sharedPreferences.getBool('onBoarding') ?? false;
  }


  Future<void> setIsUserLoggedIn() async {
    sharedPreferences.setBool('', true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool('') ?? false;
  }

  Future<void> logout() async {
    sharedPreferences.remove('');
  }



}
void signOut(context) {

  CacheHelper.removeData(key: 'email');
  CacheHelper.removeData(key: 'password');
  CacheHelper.removeData(key: 'token');
  //Navigator.pushReplacementNamed(context, LoginScreen.routeName);
}







class DarkThemePrefs {
  static const THEME_STATUS= 'THEMESTATUS';
  setDarkTheme( bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }
  Future<bool> getTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS)?? false;
  }
}

