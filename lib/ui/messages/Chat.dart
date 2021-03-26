// Step 7 (Final): Change the app's theme

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanwan/callback/ImCallBack.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/model/chat_message.dart';
import 'package:wanwan/net/Api.dart';

class ChatPage extends StatefulWidget {
  @override
  createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  var _messages = [];
  TextEditingController _textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  var user_me = "大白";
  var user_other = "小Q";

  @override
  initState() {
    super.initState();
    _messages.add(ChatMessage(user_other, OTHER, TYPE_TEXT, "嗨，在吗？"));
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        _messages.add(ChatMessage(user_other, OTHER, TYPE_TEXT, "可以认识一下吗？"));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: MyAppBar(
          title: "沙扬娜拉",
        ),
        body: Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (_, int index) {
              ChatMessage message = _messages[index];
              if (message.type_message == TYPE_TEXT) {
                if (message.type_user == 1)
                  return _buildChatRight(message.content);
                else
                  return _buildChatLeft(message.content);
              } else if (message.type_message == TYPE_IMG) {
                return _buildChatLeftImg(message.content);
              } else {
                return _buildTips("错误");
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
                hintText: '请输入内容',
                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF999999))),
          )),
          GestureDetector(
              onTap: () => _handleSubmitted(_textController.text),
              child: Container(
                //发送按钮
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.only(
                    left: 10.0, top: 6, right: 10, bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(
                  "发送",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }

  _handleSubmitted(String text) {
    if (text.isEmpty) return;
    print(text);
    setState(() {
      _messages.add(ChatMessage(user_me, ME, TYPE_TEXT, text));
      scrollToEnd();
    });
    scrollToEnd();
    _textController.clear();
    Api.getImResponse(text, ImCallBack(onNewMsg: (msg) {
      setState(() {
        _messages.add(ChatMessage(user_other, OTHER, TYPE_TEXT, msg));
        scrollToEnd();
      });
    }));
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

  //聊天左侧布局
  Widget _buildChatLeft(message) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, //对齐方式，左上对齐
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1909694165,3400923478&fm=26&gp=0.jpg'),
            radius: 20.0,
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            decoration: BoxDecoration(
              //设置背景
              color: Colors.blue,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(10.0)),
            ),
          ))
        ],
      ),
    );
  }

  //聊天右侧布局
  Widget _buildChatRight(message) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, //对齐方式，左上对齐
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
            decoration: BoxDecoration(
              //设置背景
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(10.0)),
            ),
          )),
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2182894899,3428535748&fm=58&bpow=445&bpoh=605'),
            radius: 20.0,
          ),
        ],
      ),
    );
  }

  //聊天左侧布局
  Widget _buildChatLeftImg(message) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, //对齐方式，左上对齐
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://pp.myapp.com/ma_icon/0/icon_42284557_1517984341/96'),
            radius: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Image.network(
              "https://img-blog.csdnimg.cn/20190321180257765.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9iYWl5dWxpYW5nLmJsb2cuY3Nkbi5uZXQ=,size_16,color_FFFFFF,t_70",
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
        mainAxisAlignment: MainAxisAlignment.center, //对齐方式，左上对齐
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
