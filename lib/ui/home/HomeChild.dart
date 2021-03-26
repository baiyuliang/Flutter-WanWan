import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanwan/commponets/BannerView.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/custom_behavior.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/commponets/refresh_hear.dart';
import 'package:wanwan/model/news_result_entity.dart';
import 'package:wanwan/net/Api.dart';
import 'package:wanwan/net/ResultData.dart';
import 'package:wanwan/ui/news/NewsDetail.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class HomeChildPage extends StatefulWidget {
  String type;

  HomeChildPage({this.type});

  @override
  _HomeChildPageState createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = new ScrollController();
  List<NewsResultData> news = List.empty(growable: true);

  int page = 1;

  var images = [
    "https://p4.ssl.qhimg.com/dmfd/400_300_/t018071a75e37f7186b.jpg",
    "https://p.ssl.qhimg.com/sdm/420_207_/t0111ac7b662effbfa1.jpg",
    "https://p2.ssl.qhimgs1.com/sdr/400__/t018b50020daeecb3fc.jpg"
  ];

  var inks = ["科技", "创新", "国际", "国内", "财经"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  onRefresh() {
    page = 1;
    getData();
  }

  onLoading() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomBehavior(),
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: RefreshHeader.homeHeader(),
        footer: RefreshHeader.homeFooter(),
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Expanded(
            child: Column(
              children: [
                BannerView(
                  images: images,
                  height: 140,
                  border: 10,
                  margin: const EdgeInsets.all(10),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: getInks(),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return getItem(index);
                    },
                    itemCount: news.length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getInks() {
    List<Widget> list = [];
    inks.forEach((element) {
      list.add(
        InkWell(
          onTap: () {
            Toast.show(element);
          },
          child: Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/icon_xtb.png",
                    width: 40,
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: Text(
                      element,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  )
                ],
              )),
        ),
      );
    });
    return list;
  }

  getItem(int index) {
    NewsResultData newsResultData = news[index];
    return InkWell(
      onTap: () {
        RouteUtil.push(context, NewsDetailPage(data: newsResultData));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    newsResultData.thumbnailPicS,
                    height: 80,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsResultData.title,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                newsResultData.authorName,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            Text(
                              newsResultData.date,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Line()
        ],
      ),
    );
  }

  getData() async {
    ResultData resultData = await Api.getNews(widget.type, page);
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    if (resultData.code == 0) {
      NewsResultEntity newsResultEntity = NewsResultEntity();
      newsResultEntity.fromJson(resultData.data);
      setState(() {
        if (page == 1) news.clear();
        news.addAll(newsResultEntity.data);
        page++;
      });
    } else {
      Toast.show("" + resultData.msg);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
