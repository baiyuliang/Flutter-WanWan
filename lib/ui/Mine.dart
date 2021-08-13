import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/ItemView.dart';
import 'package:wanwan/commponets/ShowDialog.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/RouteUtil.dart';
import 'package:wanwan/utils/Sp.dart';

import 'login/Login.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  User user;

  @override
  void initState() {
    super.initState();
    SpUtils.getUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "我的",
        hideBackArrow: true,
        rightImgUrl: "images/icon_setting.png",
        funRightImg: () {
          Toast.show("设置");
        },
        showLine: true,
      ),
      body: Container(
          child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 20),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      user != null
                          ? user.avatar
                          : "https://img2.baidu.com/it/u=3875436417,2934656235&fm=26&fmt=auto&gp=0.jpg",
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user != null ? user.nickname : "",
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "没有任何签名~",
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 12),
                        ),
                      ],
                    ),
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 14,
                  )
                ],
              )),
          ItemView(
            title: "我的动态",
            icon: Icon(Icons.dynamic_feed, size: 18, color: Colors.red),
            marginTop: 15,
            onTap: () {
              Toast.show("我的订单");
            },
          ),
          ItemView(
            title: "我的订单",
            image: "images/icon_mine_order.png",
            marginTop: 15,
            lineMarginLeft: 43,
            showLine: true,
            onTap: () {
              Toast.show("我的订单");
            },
          ),
          ItemView(
            title: "我的收藏",
            image: "images/icon_mine_collect.png",
            onTap: () {
              Toast.show("我的收藏");
            },
          ),
          ItemView(
            title: "客服中心",
            image: "images/icon_mine_kf.png",
            marginTop: 15,
            onTap: () {
              Toast.show("客服中心");
            },
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ShowDialog(
                      msg: "确定退出吗？",
                      positiveText: "退出",
                      positiveFun: () {
                        ImUtil.disConnect();
                        SpUtils.setUser(null);
                        RouteUtil.pushAndRemoveUntil(context, Login());
                      },
                    );
                  });
            },
            child: Container(
              height: 45,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Text("退出登录", style: TextStyle(color: Colors.redAccent)),
            ),
          )
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
