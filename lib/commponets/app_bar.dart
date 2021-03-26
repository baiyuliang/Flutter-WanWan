import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool hideBackArrow;
  String title;
  Color bgColor;
  double height;

  String rightText;
  String rightImgUrl;
  String rightImgUrl2;

  Function funBack;
  Function funRightText;
  Function funRightImg;
  Function funRightImg2;

  bool showLine;

  MyAppBar(
      {this.title = "",
      this.height = 48,
      this.bgColor = Colors.white,
      this.funBack,
      this.hideBackArrow = false,
      this.rightText,
      this.funRightText,
      this.rightImgUrl,
      this.rightImgUrl2,
      this.funRightImg,
      this.funRightImg2,
      this.showLine = false})
      : super();

  @override
  State<StatefulWidget> createState() {
    return new _MyAppBarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      color: widget.bgColor,
      child: SafeArea(
        child: Container(
            child: Stack(
          children: [
            backButton(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: widget.height,
                  right: (widget.rightImgUrl != null &&
                          widget.rightImgUrl2 != null)
                      ? widget.height * 2
                      : widget.height),
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
              ),
            ),
            showRight(),
            Visibility(
              visible: widget.showLine,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  color: Color(0xFFEEEEEE),
                  height: 0.5,
                ),
                // decoration: BoxDecoration(boxShadow: [
                //   BoxShadow(
                //       offset: Offset(0, widget.height), //x,y轴
                //       color: Color(0xFFF7F7F7),
                //       spreadRadius: 1, //阴影浓度
                //       blurRadius: 2 //阴影范围
                //       ),
                // ]),
              ),
            )
          ],
        )),
      ),
    );
  }

  showRight() {
    if (widget.rightText != null) {
      return Container(
        alignment: Alignment.centerRight,
        child: Material(
            color: widget.bgColor,
            child: InkWell(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.height / 2)),
              child: Container(
                width: widget.height,
                height: widget.height,
                alignment: Alignment.center,
                child: Text(
                  widget.rightText,
                  style: TextStyle(fontSize: 14, color: Color(0XFF333333)),
                ),
              ),
              onTap: widget.funRightText,
            )),
      );
    } else {
      if (widget.rightImgUrl != null && widget.rightImgUrl2 != null) {
        return Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              imgButton(widget.rightImgUrl, widget.funRightImg),
              imgButton(widget.rightImgUrl2, widget.funRightImg2),
            ],
          ),
        );
      } else {
        if (widget.rightImgUrl != null) {
          return Container(
            alignment: Alignment.centerRight,
            child: imgButton(widget.rightImgUrl, widget.funRightImg),
          );
        } else {
          return Text("");
        }
      }
    }
  }

  backButton() {
    if (widget.hideBackArrow) {
      return Text("");
    } else {
      return Material(
          color: widget.bgColor,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(widget.height / 2)),
            child: Container(
                width: widget.height,
                height: widget.height,
                padding: EdgeInsets.all(15),
                child: Image.asset("images/ic_back_black.png")),
            onTap: widget.funBack == null ? () {
              RouteUtil.pop(context);
            } : widget.funBack,
          ));
    }
  }

  imgButton(imgUrl, fun) {
    return Material(
        color: widget.bgColor,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(widget.height / 2)),
          child: Container(
              width: widget.height,
              height: widget.height,
              padding: EdgeInsets.all(15),
              child: Image.asset(imgUrl)),
          onTap: fun,
        ));
  }
}
