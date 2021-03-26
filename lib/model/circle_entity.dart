import 'comment_entity.dart';

class CircleEntity {
  int id;
  String avatar;
  String username;
  String date;
  String content;
  List<String> images;
  int commentCounts;
  int praiseCounts;
  int collectCounts;
  bool isPraise;
  bool isCollect;
  List<CommentEntity> comments;
}
