import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/model/news_type.dart';
import 'package:wanwan/ui/home/HomeChild.dart';
import 'package:wanwan/ui/home/OtherChild.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  List<NewsType> titles = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    titles.clear();
    titles.add(NewsType(title: "推荐", type: "top"));
    titles.add(NewsType(title: "国内", type: "guonei"));
    titles.add(NewsType(title: "国际", type: "guoji"));
    titles.add(NewsType(title: "娱乐", type: "yule"));
    titles.add(NewsType(title: "体育", type: "tiyu"));
    titles.add(NewsType(title: "军事", type: "junshi"));
    titles.add(NewsType(title: "科技", type: "keji"));
    titles.add(NewsType(title: "财经", type: "caijing"));
    titles.add(NewsType(title: "时尚", type: "shishang"));
    titles.add(NewsType(title: "游戏", type: "youxi"));
    titles.add(NewsType(title: "汽车", type: "qiche"));
    titles.add(NewsType(title: "健康", type: "jiankang"));
    tabController = TabController(length: titles.length, vsync: this);
  }

  getTabBar() {
    List<Tab> tabs = [];
    titles.forEach((element) {
      tabs.add(Tab(
        text: element.title,
      ));
    });
    return tabs;
  }

  getTabBarView() {
    List<Widget> views = [];
    for (var i = 0; i < titles.length; i++) {
      if (i == 0) {
        views.add(HomeChildPage(
          type: titles[i].type,
        ));
      } else {
        views.add(OtherChildPage(type: titles[i].type));
      }
    }
    return views;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            "images/bg_home.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            Container(
              // decoration: BoxDecoration(color: Colors.white),
              height: 45 + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10, right: 50),
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 20, color: Colors.white70),
                        Text("搜索", style: TextStyle(color: Colors.white70))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 20,
                    height: 20,
                    child: Icon(Icons.menu, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              height: 30,
              child: TabBar(
                tabs: getTabBar(),
                isScrollable: true,
                controller: tabController,
                labelColor: Colors.white,
                labelPadding: const EdgeInsets.only(left: 10, right: 10),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.white70,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicatorWeight: 1.5,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: getTabBarView(),
            ))
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
