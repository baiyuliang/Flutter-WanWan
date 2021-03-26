import 'package:flutter/cupertino.dart';

/// 键盘相关类
class KeyBoardUtils {
  static hide(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
