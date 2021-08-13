import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:wanwan/commponets/Toast.dart';
import 'package:wanwan/db/db.dart';
import 'package:wanwan/model/chat_message.dart';
import 'package:wanwan/net/Url.dart';
import 'package:wanwan/ui/base/Const.dart';
import 'package:wanwan/utils/EventBusUtil.dart';
import 'package:wanwan/utils/Sp.dart';

import 'LogUtil.dart';

class ImUtil {
  static Future<Map> register(String id, String name, String avatar) async {
    var methodChannel = const MethodChannel("rongim/server");
    Map<String, dynamic> params = <String, dynamic>{
      "id": id,
      "name": name,
      "avatar": avatar
    };
    var result = await methodChannel.invokeMethod("register", params);
    LogUtil.log("result>>$result");
    return result;
  }

  static Future<Map> getUser(String id) async {
    var methodChannel = const MethodChannel("rongim/server");
    Map<String, dynamic> params = <String, dynamic>{"id": id};
    var result = await methodChannel.invokeMethod("user", params);
    LogUtil.log("result>>$result");
    return result;
  }

  static init() {
    RongIMClient.init(Url.RONG_IM_KEY);
  }

  static connect(String token, {Function(bool) onResult}) {
    RongIMClient.connect(token, (int code, String userId) {
      if (code == 0) {
        LogUtil.log("登录成功 userId>>" + userId);
        if (onResult != null) onResult(code == 0);
      }
    });
  }

  static disConnect() {
    RongIMClient.disconnect(false);
  }

  static addStatusChangeListener() {
    RongIMClient.onConnectionStatusChange = (int connectionStatus) {
      if (RCConnectionStatus.KickedByOtherClient == connectionStatus ||
          RCConnectionStatus.TokenIncorrect == connectionStatus ||
          RCConnectionStatus.UserBlocked == connectionStatus) {
        String toast = "连接状态变化 $connectionStatus, 请退出后重新登录";
        Toast.show(toast);
        LogUtil.log(toast);
      } else if (RCConnectionStatus.Connected == connectionStatus) {
        LogUtil.log("连接成功>>");
      }
    };
  }

  //消息接收监听
  static addReceiverListener() {
    RongIMClient.onMessageReceived = (Message msg, int left) {
      LogUtil.log("收到消息>>$msg");
      String content = "";
      int type;
      var user;
      if (msg.content is TextMessage) {
        content = (msg.content as TextMessage).content;
        type = TYPE_TEXT;
        user = json.decode((msg.content as TextMessage).extra);
      } else if (msg.content is ImageMessage) {
        content = (msg.content as ImageMessage).imageUri;
        type = TYPE_IMG;
        user = json.decode((msg.content as ImageMessage).extra);
      }
      LogUtil.log(user.toString());
      ChatMessage chatMessage = ChatMessage(
          userid: msg.senderUserId,
          nickname: user["nickname"],
          avatar: user["avatar"],
          content: content,
          typeUser: OTHER,
          typeMessage: type);
      EventBusUtil.send(chatMessage);
    };
  }

  static Future<List> getConversation() async {
    return await RongIMClient.getConversationListByPage([
      RCConversationType.Private,
      RCConversationType.Group,
      RCConversationType.System
    ], 999, 0);
  }

  static sendText(String targetId, String content, User user) async {
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = content;
    txtMessage.extra =
        User(nickname: user.nickname, avatar: user.avatar).toJsonString();
    Message msg = await RongIMClient.sendMessage(
        RCConversationType.Private, targetId, txtMessage);
    Toast.show("消息发送成功");
    LogUtil.log("发送文本消息返回>>$msg");
  }

  //固定了图片地址
  static sendImage(String targetId, String url, User user) async {
    ImageMessage imageMessage = new ImageMessage();
    imageMessage.imageUri =
        "https://img0.baidu.com/it/u=4049872218,3399486661&fm=26&fmt=auto&gp=0.jpg";
    imageMessage.extra =
        User(nickname: user.nickname, avatar: user.avatar).toJsonString();
    Message msg = await RongIMClient.sendMessage(
        RCConversationType.Private, targetId, imageMessage);
    Toast.show("消息发送成功");
    LogUtil.log("发送图片消息返回>>$msg");
  }
}
