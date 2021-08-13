import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/main.dart';
import 'package:wanwan/ui/base/BaseState.dart';
import 'package:wanwan/ui/base/Const.dart';
import 'package:wanwan/utils/KeyBoard.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/RouteUtil.dart';
import 'package:wanwan/utils/Sp.dart';

import '../base/BaseStatefulWidget.dart';

class Reg extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 除半透明状态栏
    if (Theme.of(context).platform == TargetPlatform.android) {
      SystemUiOverlayStyle _style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(_style);
    }
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red, primaryColor: Colors.white),
      home: RegPage(),
    );
  }
}

class RegPage extends BaseStatefulWidget {
  @override
  RegPageState createState() => RegPageState();
}

class RegPageState extends BaseState<RegPage> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  //头像的控制器
  TextEditingController avatarController = TextEditingController();

  //昵称的控制器
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "你好，请注册",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(border: borderBottom()),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "请输入您的手机号",
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(border: borderBottom()),
                  child: TextField(
                    controller: passController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "请输入您的密码",
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(border: borderBottom()),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "请输入您的昵称",
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(border: borderBottom()),
                  child: TextField(
                    controller: avatarController,
                    keyboardType: TextInputType.url,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "请输入您的头像地址",
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  margin: const EdgeInsets.only(top: 50),
                  child: Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Center(
                        child: Text("注册",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      onTap: () => login(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  borderBottom() {
    return Border(
        bottom: BorderSide(
            width: 1, style: BorderStyle.solid, color: Color(0xFFDDDDDD)));
  }

  login() async {
    if (phoneController.text.isEmpty) {
      Toast.show("手机号不能为空");
      return;
    }
    if (phoneController.text.length != 11 ||
        !phoneController.text.startsWith("1")) {
      Toast.show("请输入正确的手机号");
      return;
    }

    User user = await AppDatabase.getInstance().getUser(phoneController.text);
    if (user != null) {
      Toast.show("该手机号已注册");
      return;
    }

    if (passController.text.isEmpty) {
      Toast.show("请输入密码");
      return;
    }
    if (nameController.text.isEmpty) {
      Toast.show("请输入昵称");
      return;
    }
    if (avatarController.text.isEmpty) {
      Toast.show("请填写头像地址");
      return;
    }
    KeyBoardUtils.hide(context);

    showLoading();
    ImUtil.register(
            phoneController.text, nameController.text, avatarController.text)
        .then((map) {
      dismissLoading();
      if (map["code"] == 200) {
        User user = User(
            userid: phoneController.text,
            pwd: passController.text,
            nickname: nameController.text,
            avatar: avatarController.text,
            imToken: map["token"]);
        AppDatabase.getInstance().insertUser(user);
        Toast.show("注册成功");
        RouteUtil.pop(context);
      } else {
        Toast.show(map["error"]);
      }
    });
  }
}
