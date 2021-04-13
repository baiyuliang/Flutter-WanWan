import 'comment_entity.dart';

class CircleEntity {
  int id;
  String avatar;
  String username;
  String date;
  String content;
  List<String> images;
  VideoData videoData;
  int commentCounts;
  int praiseCounts;
  int collectCounts;
  bool isPraise;
  bool isCollect;
  List<CommentEntity> comments;
}

class VideoData{
  String coverImg;
  String videoUrl;
}