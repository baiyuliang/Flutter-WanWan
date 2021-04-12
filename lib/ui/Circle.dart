import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/data/DataUtils.dart';
import 'package:wanwan/model/circle_entity.dart';
import 'package:wanwan/model/comment_entity.dart';
import 'package:wanwan/ui/common/GalleryImagePreview.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class CirclePage extends StatefulWidget {
  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  ScrollController scrollController = ScrollController();
  List<CircleEntity> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List<CircleEntity> datas = await DataUtils.getCircleData();
    setState(() {
      if (page == 1) list.clear();
      list.addAll(datas);
    });
  }

  getReplyItem(CommentEntity commentEntity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commentEntity.replyUsername != null
                ? commentEntity.username
                : "${commentEntity.username}：",
            style: TextStyle(
                fontSize: 12,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          Visibility(
              visible: commentEntity.replyUsername != null,
              child: Row(
                children: [
                  Text(" 回复 ",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("${commentEntity.replyUsername}：",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                ],
              )),
          Flexible(
              child: Text(commentEntity.content,
                  style: TextStyle(fontSize: 12, color: Color(0xFF333333))))
        ],
      ),
    );
  }

  getReplyItem2(CommentEntity commentEntity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: commentEntity.replyUsername != null
                ? commentEntity.username
                : "${commentEntity.username}：",
            style: TextStyle(
                fontSize: 12,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: commentEntity.replyUsername != null ? " 回复 " : "",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          TextSpan(
              text: commentEntity.replyUsername != null
                  ? "${commentEntity.replyUsername}："
                  : "",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: commentEntity.content,
              style: TextStyle(fontSize: 12, color: Color(0xFF333333)))
        ]),
      ),
    );
  }

  iconText(imgPath, count) {
    return InkWell(
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imgPath, width: 18, height: 18),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
              ),
            )
          ],
        ),
      ),
    );
  }

  getItem(index) {
    double imgWidth = (MediaQuery.of(context).size.width - 60 - 30) / 3;
    CircleEntity circleEntity = list[index];
    return InkWell(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //左侧头像
                ClipOval(
                  child: Image.network(
                    circleEntity.avatar,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                //右侧内容
                Flexible(
                    child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //姓名，时间
                      Container(
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              circleEntity.username,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(circleEntity.date,
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF999999))),
                          ],
                        ),
                      ),
                      //具体内容+图片
                      Visibility(
                          visible: circleEntity.images != null &&
                              circleEntity.images.length > 0,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Text(circleEntity.content,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF333333))),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: GridView.count(
                                    //解决ListView嵌套GridView滑动冲突
                                    physics: new NeverScrollableScrollPhysics(),
                                    //解决GridView展示不出来的问题
                                    shrinkWrap: true,
                                    //水平子Widget之间间距
                                    crossAxisSpacing: 10,
                                    //垂直子Widget之间间距
                                    mainAxisSpacing: 10,
                                    //一行的Widget数量
                                    crossAxisCount: 3,
                                    //子Widget宽高比例
                                    childAspectRatio: 1,
                                    //子Widget列表
                                    children: List.generate(
                                      circleEntity.images == null
                                          ? 0
                                          : circleEntity.images.length,
                                      (imgIndex) {
                                        return InkWell(
                                          onTap: () => RouteUtil.push(
                                              context,
                                              GalleryImagePreview(
                                                galleryItems:
                                                    list[index].images,
                                                index: imgIndex,
                                              )),
                                          child: Image.network(
                                            circleEntity.images[imgIndex],
                                            width: imgWidth,
                                            height: imgWidth,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      //评论
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          physics: new NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return getReplyItem2(circleEntity.comments[index]);
                          },
                          itemCount: circleEntity.comments == null
                              ? 0
                              : circleEntity.comments.length,
                        ),
                      ),
                      //评论点赞收藏
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            iconText("images/icon_circle_comment.png",
                                circleEntity.commentCounts),
                            iconText("images/icon_collect.png",
                                circleEntity.collectCounts),
                            iconText("images/icon_circle_zan.png",
                                circleEntity.praiseCounts)
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          Line()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "圈子",
          hideBackArrow: true,
          showLine: true,
        ),
        body: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            controller: scrollController,
            itemBuilder: (context, index) {
              return getItem(index);
            },
            itemCount: list.length));
  }

  @override
  bool get wantKeepAlive => true;
}
