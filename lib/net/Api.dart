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

  static _getImSign(params) {
    params += "&app_key=${Url.IM_APP_KEY}";
    var sign = md5.convert(utf8.encode(params));
    return sign.toString().toUpperCase();
  }

  static getImResponse(question, ImCallBack imCallBack) async {
    // var param = {
    //   "app_id": Url.IM_APP_ID,
    //   "nonce_str": "fa577ce340859f9fe",
    //   "question": Uri.encodeFull(question),
    //   "session": 10000,
    //   "time_stamp": DateTime.now().millisecondsSinceEpoch ~/ 1000,
    // };
    // var sign = _getImSign(
    //     "app_id=${param['app_id']}&nonce_str=${param['nonce_str']}&question=${param['question']}&session=${param['session']}&time_stamp=${param['time_stamp']}");
    // param.putIfAbsent("sign", () => sign);
    // var res = await Dio().post(Url.IM_URL,
    //     queryParameters: param,
    //     options: Options(
    //         headers: {'Content-Type': 'application/x-www-form-urlencoded'}));
    // print("${res.statusCode}>>${res.data}");
    // RobotMessage robotMessage = RobotMessage(res.data);
    // if (robotMessage.ret == 0 &&
    //     robotMessage.data != null &&
    //     robotMessage.data.answer.isNotEmpty) {
    //   imCallBack.onNewMsg(robotMessage.data.answer);
    // } else {
    //   imCallBack.onNewMsg(question);
    // }

    var params =
        "app_id=${Url.IM_APP_ID}&nonce_str=fa577ce340859f9fe&question=${Uri.encodeFull(question)}&session=10000&time_stamp=${DateTime.now().millisecondsSinceEpoch ~/ 1000}";
    http
        .post(Uri.parse(Url.IM_URL),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: params + "&sign=" + _getImSign(params))
        .then((res) {
      print('res>>${res.body}');
      RobotMessage robotMessage = RobotMessage(json.decode(res.body));
      if (robotMessage.ret == 0 &&
          robotMessage.data != null &&
          robotMessage.data.answer.isNotEmpty) {
        imCallBack.onNewMsg(robotMessage.data.answer);
      } else {
        imCallBack.onNewMsg(question);
      }
    });
  }
}
