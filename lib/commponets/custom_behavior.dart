import 'dart:io';
import 'package:flutter/cupertino.dart';

///去除滑动回弹效果
class CustomBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildViewportChrome(context, child, axisDirection);
  }
}
