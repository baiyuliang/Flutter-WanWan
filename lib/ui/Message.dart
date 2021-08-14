import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/model/MyConversation.dart';
import 'package:wanwan/net/Url.dart';
import 'package:wanwan/ui/messages/Chat.dart';
import 'package:wanwan/ui/messages/RobotChat.dart';
import 'package:wanwan/ui/messages/SearchUser.dart';
import 'package:wanwan/utils/LogUtil.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  List<MyConversation> conversationList = [];

  @override
  void initState() {
    super.initState();
    //添加机器人
    MyConversation conversation = MyConversation();
    conversation.userid = "robot";
    conversationList.add(conversation);
    refreshConversations();
    //3s刷新一次
    Timer.periodic(Duration(seconds: 5), (timer) {
      refreshConversations();
    });
  }

  void refreshConversations() {
    ImUtil.getConversation().then((list) {
      if (list != null) {
        setState(() {
          conversationList.clear();
          //添加机器人
          MyConversation conversation = MyConversation();
          conversation.userid = "robot";
          conversationList.add(conversation);
          //添加会话列表
          list.forEach((element) {
            MyConversation conversation = MyConversation();
            if (element is Conversation) {
              conversation.userid = element.senderUserId;
              var user;
              if (element.latestMessageContent != null) {
                if (element.latestMessageContent is TextMessage) {
                  conversation.content =
                      (element.latestMessageContent as TextMessage).content;
                  user = jsonDecode(
                      (element.latestMessageContent as TextMessage).extra);
                } else if (element.latestMessageContent is ImageMessage) {
                  conversation.content = "[图片]";
                  user = jsonDecode(
                      (element.latestMessageContent as ImageMessage).extra);
                }
                conversation.nickname = user["nickname"];
                conversation.avatar = user["avatar"];
                conversationList.add(conversation);
              }
            }
          });
        });
      }
    });
  }

  getItem(MyConversation conversation) {
    return InkWell(
      onTap: () {
        if (isRobot(conversation)) {
          RouteUtil.push(context, RobotChatPage());
        } else {
          User userSender = User(
              userid: conversation.userid,
              nickname: conversation.nickname,
              avatar: conversation.avatar);
          RouteUtil.push(context, ChatPage(userSender: userSender));
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    isRobot(conversation)
                        ? Url.AVATAR_ROBOT
                        : conversation.avatar,
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
                              isRobot(conversation)
                                  ? "机器人小助手"
                                  : conversation.nickname,
                            ),
                            Text(
                              isRobot(conversation) ? "" : "刚刚",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, right: 30),
                          child: Text(
                            isRobot(conversation)
                                ? "你好，我是机器人助手，有什么可以为您服务的吗？"
                                : conversation.content,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
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
    super.build(context);
    return Scaffold(
        appBar: MyAppBar(
          title: "消息",
          hideBackArrow: true,
          showLine: true,
          rightText: "添加",
          funRightText: () {
            RouteUtil.push(context, SearchUserPage());
          },
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return getItem(conversationList[index]);
            },
            itemCount: conversationList.length));
  }

  @override
  bool get wantKeepAlive => true;

  bool isRobot(MyConversation conversation) {
    return conversation.userid == "robot";
  }
}
