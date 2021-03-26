import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/ui/messages/Chat.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  getItem(int index) {
    return InkWell(
      onTap: () {
        RouteUtil.push(context, ChatPage());
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1909694165,3400923478&fm=26&gp=0.jpg",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "沙扬娜拉",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "刚刚",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          "嗨，在吗？",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "消息",
          hideBackArrow: true,
          showLine: true,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return getItem(index);
            },
            itemCount: 6));
  }

  @override
  bool get wantKeepAlive => true;
}
