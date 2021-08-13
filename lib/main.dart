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
import 'package:wanwan/utils/LogUtil.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/Sp.dart';


class MyApp extends StatelessWidget {
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
      // theme: ThemeData(primarySwatch: Colors.grey, primaryColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final List<String> tab = ["首页", "消息", "圈子", "我的"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tab.length, vsync: this);
    ImUtil.init();
    SpUtils.get(IM_TOKEN).then((token) => ImUtil.connect(token));
    ImUtil.addStatusChangeListener();
    ImUtil.addReceiverListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.white,
        child: Container(
          height: 60,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                iconMargin: const EdgeInsets.all(0),
                child: Text(tab[0], style: TextStyle(fontSize: 12)),
              ),
              Tab(
                icon: Icon(Icons.message),
                iconMargin: const EdgeInsets.all(0),
                child: Text(tab[1], style: TextStyle(fontSize: 12)),
              ),
              Tab(
                icon: Icon(Icons.dynamic_feed),
                iconMargin: const EdgeInsets.all(0),
                child: Text(tab[2], style: TextStyle(fontSize: 12)),
              ),
              Tab(
                icon: Icon(Icons.person),
                iconMargin: const EdgeInsets.all(0),
                child: Text(tab[3], style: TextStyle(fontSize: 12)),
              ),
            ],
            indicatorColor: Colors.white,
            controller: tabController,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(
            child: HomePage(),
          ),
          Center(
            child: MessagePage(),
          ),
          Center(
            child: CirclePage(),
          ),
          Center(
            child: MinePage(),
          ),
        ],
      ),
    );
  }
}
