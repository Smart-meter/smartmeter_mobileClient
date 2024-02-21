

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper{

  static SharedPreferences? prefs;


 static Future<SharedPreferences> getPrefs() async{
  return prefs =  await SharedPreferences.getInstance();

  }

 static Future<String> getStringValue(String key) async{

   if(prefs==null) {
     await getPrefs();
   }
     return prefs?.getString(key) ?? "";
  }





}