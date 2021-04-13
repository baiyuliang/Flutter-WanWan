import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Toast.dart';

class ItemView extends StatefulWidget {
  String title;
  Icon icon;
  String image;
  int height;
  double lineMarginLeft;
  double lineMarginRight;
  double marginTop;
  bool showLine;
  Function onTap;

  ItemView({this.title,
    this.icon,
    this.image,
    this.height,
    this.lineMarginLeft,
    this.lineMarginRight,
    this.marginTop,
    this.showLine,
    this.onTap})
      : super();

  @override
  State<StatefulWidget> createState() {
    return MyItemView();
  }
}

class MyItemView extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: widget.marginTop ?? 0),
            decoration: BoxDecoration(color: Colors.white),
            height: widget.height ?? 48,
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Visibility(
                        visible: showIcon(),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: getIcon(),
                        )),
                    Text(
                      widget.title ?? "",
                      style: TextStyle(color: Color(0xFF333333), fontSize: 14),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 14,
                )
              ],
            ),
          ),
          Visibility(
              visible: widget.showLine ?? false,
              child: Container(
                margin: EdgeInsets.only(
                    left: widget.lineMarginLeft ?? 0,
                    right: widget.lineMarginRight ?? 0),
                child: Divider(
                  color: Color(0xFFDDDDDD),
                  height: 0.3,
                ),
              ))
        ],
      ),
    );
  }

  bool showIcon() {
    return !(widget.image == null && widget.icon == null);
  }

  Widget getIcon() {
    if (widget.image != null) {
      return Image.asset(
        widget.image,
        width: 18,
        height: 18,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    }
    return null;
  }
}
