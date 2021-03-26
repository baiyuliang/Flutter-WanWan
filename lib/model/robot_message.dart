import 'dart:convert';

class RobotMessage {
  int ret;
  var msg;
  RobotData data;

  RobotMessage(json) {
    var map = Map.from(json);
    ret = map['ret'];
    msg = map['msg'];
    var _data = map['data'];
    data = RobotData(_data);
  }
}

class RobotData {
  var session;
  String answer;

  RobotData(data) {
    session = data['session'];
    answer = data['answer'];
  }
}
