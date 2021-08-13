import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:wanwan/callback/ImCallBack.dart';
import 'package:wanwan/model/robot_message.dart';

import 'DataHelper.dart';
import 'HttpManager.dart';
import 'Url.dart';

import 'package:http/http.dart' as http;

///由于api调用的是第三方，所以base_url并不统一
class Api {
  static getNews(String type, int page) {
    SplayTreeMap params = DataHelper.getNullBaseMap();
    params['type'] = type;
    params['page'] = page;
    params['page_size'] = 20;
    params['key'] = "0423199ec7dab2840658f9830cd3a0b8";
    return HttpManager.getInstance().get(Url.NEWS, params: params);
  }

  static getNewsDetail(String uniquekey) {
    SplayTreeMap params = DataHelper.getNullBaseMap();
    params['uniquekey'] = uniquekey;
    params['key'] = "0423199ec7dab2840658f9830cd3a0b8";
    return HttpManager.getInstance().get(Url.NEWS_DETAIL, params: params);
  }

  static getImageCategory() {
    return HttpManager.getInstance().get(Url.IMAGES_CATEGORY);
  }

  static getImageList(int cid, int start) {
    return HttpManager.getInstance()
        .get(Url.IMAGES_LIST + "&cid=$cid&start=$start&count=20");
  }

  // static _getImSign(params) {
  //   params += "&app_key=${Url.IM_APP_KEY}";
  //   var sign = md5.convert(utf8.encode(params));
  //   return sign.toString().toUpperCase();
  // }

  //机器人聊天
  static getRobotResponse(question, Function(String) onResult) async {
    http.get(Uri.parse(Url.ROBOT_URL + question)).then((res) {
      print('res>>${res.body}');
      RobotMessage robotMessage = RobotMessage(json.decode(res.body));
      if (robotMessage.code == 200 &&
          robotMessage.data != null &&
          robotMessage.data.reply.isNotEmpty) {
        onResult(robotMessage.data.reply);
      } else {
        onResult("服务器错误");
      }
    });
  }
}
