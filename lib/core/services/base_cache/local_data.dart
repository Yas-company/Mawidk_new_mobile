// import 'dart:convert';
//
// import 'package:mawidak/core/base_network/base_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocalData {
//   final SharedPreferences sharedPreferences;
//
//   LocalData(this.sharedPreferences);
//
//   // this is the function that will save the string you need to provide the key as a constant from constant String file
//   Future<bool> saveString(String string, String key) async {
//     return sharedPreferences.setString(key, string);
//   }
//
//   // this will retrieve the string using the key you want
//   Future<String?> getString(String key) async {
//     final String? jsonString = sharedPreferences.getString(key);
//     return jsonString;
//   }
//
//   // this will save an object by converting it into a json string
//   Future<bool> saveModel(model, String key) async {
//     var thing = model.toJson();
//     return sharedPreferences.setString(key, json.encode(thing));
//   }
//
//   // and this will get the object by converting the json string that we saved
//   Future<dynamic> getModel<T extends BaseModel>(String key, {required model}) {
//     final String jsonString = sharedPreferences.getString(key) ?? "";
//
//     if (jsonString != "") {
//       final Map<String, dynamic> jsonMap = json.decode(jsonString);
//       dynamic thing = model.fromJson(jsonMap);
//       return Future.value(thing);
//     } else {
//       return Future.value(null);
//     }
//   }
//
//   Future<bool> clear() async {
//     return sharedPreferences.clear();
//   }
// }
