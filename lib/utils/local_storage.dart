// import 'dart:developer';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// class SharedPref {
//   // read(String key) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   return json.decode(prefs.getString(key).toString());
//   // }
//   //
//   // save(String key, value) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   prefs.setString(key, json.encode(value));
//   // }
//
//   static saveTokenToStorage({required String tokenValue}) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('token', tokenValue);
//     // log('Token is Saved to shared Preferences Token is = $tokenValue');
//   }
//
//   static showTokenToStorage(String displayToken) async {
//     final prefs = await SharedPreferences.getInstance();
//     String displayToken = prefs.getString('token')!;
//     return displayToken;
//     log(displayToken);
//   }
//
//   // remove(String key) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   prefs.remove(key);
//   // }
// }

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  setBoolValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  setListOfString(String key, final value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, value);
  }

  setIntValue(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  setDoubleValue(String key, double value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setDouble(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  Future<dynamic> getBoolValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? "";
  }

  Future<dynamic> getListOfString(List<String> key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key.toString()) ?? "";
  }

  Future<int> getIntValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? 0;
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return await myPrefs.clear();
  }

  updateAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return await myPrefs.reload();
  }
}
