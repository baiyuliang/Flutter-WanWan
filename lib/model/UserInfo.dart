class UserInfo {
  String id;
  String username;
  String nickname;
  String pwd;
  String avatar;
  String sign;

  //构造函数：加{}和不加的区别
  //加{},则可以在new对象时，选择性的初始化参数，而不加{}则必须全部初始化
  // UserInfo userInfo=UserInfo(id:"1", username:"大白", avatar:"")
  //UserInfo userInfo=UserInfo("1", "大白", avatar:"",sign:"")
  UserInfo({this.id, this.username,  this.pwd, this.nickname,this.avatar, this.sign});
}
