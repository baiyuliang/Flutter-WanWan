import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/main.dart';
import 'package:wanwan/ui/base/BaseState.dart';
import 'package:wanwan/ui/login/Reg.dart';
import 'package:wanwan/utils/KeyBoard.dart';
import 'package:wanwan/utils/RouteUtil.dart';
import 'package:wanwan/utils/Sp.dart';

import '../base/BaseStatefulWidget.dart';

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
    // SpUtils.get(IM_TOKEN).then((token) {
    //   if (token.isNotEmpty) {
    //     RouteUtil.pushAndRemoveUntil(context, MyHomePage());
    //   }
    // });
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
                  margin: const EdgeInsets.only(top: 50, bottom: 10),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        RouteUtil.push(context, RegPage());
                      },
                      child: Text(
                        "立即注册",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    )
                  ],
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

    toLogin();
  }

  //由于融云登录需要用imtoken，所以token必须存储起来，
  // 此处的登录就是一个模拟用账号密码请求服务器（从数据库查询）并返回用户信息以及token的过程
  toLogin() async {
    //从数据库查询
    showLoading();
    User user = await AppDatabase.getInstance()
        .getUserByPwd(phoneController.text, passController.text);
    if (user != null) {
      SpUtils.setUser(user).then((value) {
        dismissLoading();
        toMainPage();
      });
    } else {
      dismissLoading();
      Toast.show("账号或密码错误");
    }
  }

  toMainPage() {
    RouteUtil.pushAndRemoveUntil(context, MyHomePage());
  }
}
