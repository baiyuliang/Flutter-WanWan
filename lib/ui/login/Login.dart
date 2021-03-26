import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/main.dart';
import 'package:wanwan/ui/base/BaseState.dart';
import 'package:wanwan/utils/KeyBoard.dart';
import 'package:wanwan/utils/RouteUtil.dart';

import '../base/BaseStatefulWidget.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
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
      home: LoginPage(),
    );
  }
}

class LoginPage extends BaseStatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseState<LoginPage> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

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
                      "你好，请登录",
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
                  width: double.infinity,
                  height: 40,
                  margin: const EdgeInsets.only(top: 50),
                  child: Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Center(
                        child: Text("登录",
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

  login() {
    if (phoneController.text.isEmpty) {
      Toast.show("手机号不能为空");
      return;
    }
    if (phoneController.text.length != 11 ||
        !phoneController.text.startsWith("1")) {
      Toast.show("请输入正确的手机号");
      return;
    }
    if (passController.text.isEmpty) {
      Toast.show("请输入密码");
      return;
    }

    KeyBoardUtils.hide(context);

    toMainPage();
  }

  toMainPage() async {
    showLoading();
    await Future.delayed(Duration(milliseconds: 1500));
    dismissLoading();
    RouteUtil.pushAndRemoveUntil(context, MyHomePage());
  }
}
