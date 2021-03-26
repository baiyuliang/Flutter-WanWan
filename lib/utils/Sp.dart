import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{
  // 设置数据的方法
  static Future<void> set(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static Future<String> get(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<void> remove(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  static Future<void> clear() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

}