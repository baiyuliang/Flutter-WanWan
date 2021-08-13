import 'dart:convert';

class RobotMessage {
  int code;
  String msg;
  List newslist;
  RobotData data;

  RobotMessage(json) {
    var map = Map.from(json);
    code = map['code'];
    msg = map['msg'];
    newslist = map['newslist'];
    data = RobotData(newslist[0]);
  }
}

class RobotData {
  String datatype;
  String reply;

  RobotData(data) {
    datatype = data['datatype'];
    reply = data['reply'];
  }
}
