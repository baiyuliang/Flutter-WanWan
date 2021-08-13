import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/ui/base/Const.dart';

class SpUtils {
  // 设置数据的方法
  static Future<void> set(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static Future<String> get(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<void> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  static Future<void> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  static Future<void> setUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (user != null) {
      sp.setString(IM_TOKEN, user.imToken);
      sp.setString(USER_ID, user.userid);
      sp.setString(PWD, user.pwd);
      sp.setString(NICK_NAME, user.nickname);
      sp.setString(USER_AVATAR, user.avatar);
    } else {
      sp.setString(IM_TOKEN, "");
      sp.setString(USER_ID, "");
      sp.setString(PWD, "");
      sp.setString(NICK_NAME, "");
      sp.setString(USER_AVATAR, "");
    }
  }

  static Future<User> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return User(
        userid: sp.getString(USER_ID),
        pwd: sp.getString(PWD),
        nickname: sp.getString(NICK_NAME),
        avatar: sp.getString(USER_AVATAR),
        imToken: sp.getString(IM_TOKEN));
  }
}
