import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanwan/commponets/line.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/RouteUtil.dart';

import 'Chat.dart';

class UserDetailPage extends StatefulWidget {
  String userid;

  UserDetailPage(this.userid);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  User user;

  @override
  void initState() {
    super.initState();
    ImUtil.getUser(widget.userid).then((map) {
      setState(() {
        user = User(
            userid: widget.userid,
            nickname: map["name"],
            avatar: map["avatar"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Image.network(
                      user.avatar,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: 30,
                  ),
                ),
                InkWell(
                  child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(15),
                      child: Image.asset("images/ic_back_black.png")),
                  onTap: () => RouteUtil.pop(context),
                )
              ],
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Text("用户名：${user.nickname}"),
            ),
            Line(),
            Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.only(
                  top: 50, bottom: 10, left: 15, right: 15),
              child: Material(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Center(
                    child: Text("发消息",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  onTap: () {
                    RouteUtil.push(context, ChatPage(userSender: user));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
