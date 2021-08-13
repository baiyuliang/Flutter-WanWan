const ME = 1;
const OTHER = 0;
const TYPE_TEXT = 1;
const TYPE_IMG = 2;

class ChatMessage {
  String userid;
  String nickname;
  String avatar;
  String content;
  int typeUser; //1：自己 0：对方
  int typeMessage; //1.文本
  String date;

  ChatMessage(
      {this.userid,
      this.nickname,
      this.avatar,
      this.content,
      this.typeUser,
      this.typeMessage,
      this.date});
}
