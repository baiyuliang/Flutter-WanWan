import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:wanwan/net/Url.dart';
import 'package:wanwan/ui/Home.dart';
import 'package:wanwan/ui/Circle.dart';
import 'package:wanwan/ui/Message.dart';
import 'package:wanwan/ui/Mine.dart';
import 'package:wanwan/ui/base/Const.dart';
import 'package:wanwan/ui/login/Login.dart';
import 'package:wanwan/utils/LogUtil.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/RouteUtil.dart';
import 'package:wanwan/utils/Sp.dart';

import 'main.dart';

main() {
  runApp(Splash());
}

class Splash extends StatelessWidget {
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
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      SpUtils.get(IM_TOKEN).then((token) {
        if (token.isNotEmpty) {
          RouteUtil.pushAndRemoveUntil(context, MyHomePage());
        } else {
          RouteUtil.pushAndRemoveUntil(context, Login());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "WanWan",
          style: TextStyle(
              color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
