// Step 7 (Final): Change the app's theme

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/model/chat_message.dart';
import 'package:wanwan/utils/EventBusUtil.dart';
import 'package:wanwan/utils/LogUtil.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/Sp.dart';

class ChatPage extends StatefulWidget {
  final User userSender;

  const ChatPage({Key key, this.userSender}) : super(key: key);

  @override
  createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  User userInfo, userSender;
  var _messages = [];
  TextEditingController _textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    userSender=widget.userSender;

    SpUtils.getUser().then((value) {
      setState(() {
        userInfo = value;
      });
    });
    EventBusUtil.receiver((object) {
      LogUtil.log("event>>$object");
      setState(() {
        _messages.add(object);
        scrollToEnd();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: MyAppBar(
          title: userInfo != null ? userInfo.nickname : "",
        ),
        body: Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (_, int index) {
              ChatMessage message = _messages[index];
              if (message.typeMessage == TYPE_TEXT) {
                if (message.typeUser == 1)
                  return _buildChatRight(message);
                else
                  return _buildChatLeft(message);
              } else if (message.typeMessage == TYPE_IMG) {
                return _buildChatLeftImg(message);
              } else {
                return _buildTips("??????");
              }
            },
            itemCount: _messages.length,
          )),
          Divider(height: 1.0),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildEditText(),
          )
        ]));
  }

  Widget _buildEditText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            style: TextStyle(color: Color(0xFF333333), fontSize: 14),
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration: InputDecoration.collapsed(
                hintText: '???????????????',
                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF999999))),
          )),
          GestureDetector(
              onTap: () => _handleSubmitted(_textController.text),
              child: Container(
                //????????????
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.only(
                    left: 10.0, top: 6, right: 10, bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(
                  "??????",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
          GestureDetector(
              onTap: () => _handleSubmitted("??????"),
              child: Container(
                //????????????
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.only(
                    left: 10.0, top: 6, right: 10, bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(
                  "??????",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }

  _handleSubmitted(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
          userid: userInfo.userid,
          avatar: userInfo.avatar,
          nickname: userInfo.nickname,
          typeUser: ME,
          typeMessage: TYPE_TEXT,
          content: text));
      scrollToEnd();
      _textController.clear();
    });

    //??????????????????
    if (text == "??????")
      ImUtil.sendImage(userSender.userid, text, userInfo);
    else
      ImUtil.sendText(userSender.userid, text, userInfo);
  }

  scrollToEnd() {
    // Timer(Duration(milliseconds: 100), () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
    Timer(
        Duration(milliseconds: 100),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.ease));
  }

  //??????????????????
  Widget _buildChatLeft(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, //???????????????????????????
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(message.avatar),
            radius: 20.0,
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.content,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            decoration: BoxDecoration(
              //????????????
              color: Colors.blue,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(10.0)),
            ),
          ))
        ],
      ),
    );
  }

  //??????????????????
  Widget _buildChatRight(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, //???????????????????????????
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.content,
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
            decoration: BoxDecoration(
              //????????????
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(10.0)),
            ),
          )),
          CircleAvatar(
            backgroundImage: NetworkImage(message.avatar),
            radius: 20.0,
          ),
        ],
      ),
    );
  }

  //??????????????????
  Widget _buildChatLeftImg(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, //???????????????????????????
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(message.avatar),
            radius: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Image.network(
              message.content,
              height: 200,
              width: 150,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  //
  Widget _buildTips(message) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, //???????????????????????????
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
