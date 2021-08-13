import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/commponets/custom_behavior.dart';
import 'package:wanwan/model/news_detail_entity.dart';
import 'package:wanwan/model/news_result_entity.dart';
import 'package:wanwan/net/Api.dart';
import 'package:wanwan/net/ResultData.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:wanwan/ui/common/GalleryImagePreview.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsResultData data;

  NewsDetailPage({this.data});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  String content;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ResultData resultData = await Api.getNewsDetail(widget.data.uniquekey);
    NewsDetailEntity newsDetailEntity = NewsDetailEntity();
    newsDetailEntity.fromJson(resultData.data);
    if (resultData.code != 0) {
      Toast.show(resultData.msg);
    }
    setState(() {
      this.content = newsDetailEntity.content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "新闻详情",
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ScrollConfiguration(
              behavior: CustomBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        widget.data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.authorName,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            widget.data.date,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Html(
                      // 渲染的数据
                      data: content ?? "",
                      // 自定义样式
                      style: {
                        "p": Style(
                            color: Color(0xFF333333),
                            fontSize: FontSize.larger,
                            lineHeight: LineHeight.percent(130)),
                      },
                      customRender: {},
                      onLinkTap: (url, _context, attrs, element) {
                        Toast.show("Opening $url...");
                      },
                      onImageTap: (src, _context, attrs, element) {
                        RouteUtil.push(
                            context,
                            GalleryImagePreview(
                              galleryItems: [src],
                              index: 0,
                            ));
                      },
                      onImageError: (exception, stackTrace) {
                        print(exception);
                      },
                    ),
                  ],
                ),
              ))),
    );
  }
}
