import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  double height;
  Color color;

  Line({this.height, this.color}) : super();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color == null ? Color(0xFFDDDDDD) : color,
      height: height == null ? 0.1 : height,
    );
  }
}
