import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/commponets/app_bar.dart';
import 'package:wanwan/ui/base/BaseState.dart';
import 'package:wanwan/utils/ImUtil.dart';
import 'package:wanwan/utils/KeyBoard.dart';
import 'package:wanwan/utils/RouteUtil.dart';

import '../base/BaseStatefulWidget.dart';
import 'UserDetail.dart';

class SearchUserPage extends BaseStatefulWidget {
  @override
  createState() => SearchUserPageState();
}

class SearchUserPageState extends BaseState<SearchUserPage> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: MyAppBar(
          title: "搜索",
        ),
        body: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: borderBottom()),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "请输入用户手机号",
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.all(15),
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Center(
                  child: Text("搜索",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                onTap: () => search(),
              ),
            ),
          ),
        ]));
  }

  borderBottom() {
    return Border(
        bottom: BorderSide(
            width: 1, style: BorderStyle.solid, color: Color(0xFFDDDDDD)));
  }

  search() {
    if (phoneController.text.isEmpty) {
      Toast.show("手机号不能为空");
      return;
    }
    if (phoneController.text.length != 11 ||
        !phoneController.text.startsWith("1")) {
      Toast.show("请输入正确的手机号");
      return;
    }

    KeyBoardUtils.hide(context);

    showLoading();
    ImUtil.getUser(phoneController.text).then((map) {
      dismissLoading();
      if (map["code"] == 200) {
        RouteUtil.push(context, UserDetailPage(phoneController.text));
      } else {
        Toast.show(map["error"]);
      }
    });
  }
}
