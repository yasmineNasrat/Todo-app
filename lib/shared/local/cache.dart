import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putBooleanData (String key , bool value) async{
    return await sharedPreferences.setBool(key, value)
        .then((value){
      if(value){
        print('successfully cached');
      }
    }).catchError((error){
      print('error cached');
    });
  }

  static bool getBooleanData(String key){
    return sharedPreferences.getBool(key);
  }

}