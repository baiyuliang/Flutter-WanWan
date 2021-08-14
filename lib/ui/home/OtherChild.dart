import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/BannerView.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/model/news_result_entity.dart';
import 'package:wanwan/net/Api.dart';
import 'package:wanwan/net/ResultData.dart';
import 'package:wanwan/ui/news/NewsDetail.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class OtherChildPage extends StatefulWidget {
  String type;

  OtherChildPage({this.type});

  @override
  _OtherChildPageState createState() => _OtherChildPageState();
}

class _OtherChildPageState extends State<OtherChildPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = new ScrollController();
  List<NewsResultData> news = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        controller: scrollController,
        itemBuilder: (context, index) {
          return getItem(index);
        },
        itemCount: news.length);
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
    ResultData resultData = await Api.getNews(widget.type, 1);
    NewsResultEntity newsResultEntity = NewsResultEntity();
    newsResultEntity.fromJson(resultData.data);
    setState(() {
      news.addAll(newsResultEntity.data);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
