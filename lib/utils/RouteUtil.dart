import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteUtil {
  static pushAndRemoveUntil(context, page) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => route == null);
  }

  static push(context, page) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }

  static pop(context) {
    Navigator.pop(context);
  }
}
