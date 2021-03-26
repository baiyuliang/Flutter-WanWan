typedef OnNewMsg = Function(String msg);

 class ImCallBack {
  OnNewMsg onNewMsg;

  ImCallBack({this.onNewMsg});
}
