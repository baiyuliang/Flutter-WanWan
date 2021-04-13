import 'package:wanwan/model/circle_entity.dart';
import 'package:wanwan/model/comment_entity.dart';

class DataUtils {
  static getCircleData() {
    List<CircleEntity> list = [];
    CircleEntity circleEntity = CircleEntity();
    circleEntity.id = 1;
    circleEntity.avatar =
        "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1909694165,3400923478&fm=26&gp=0.jpg";
    circleEntity.username = "火舞";
    circleEntity.content = "发个自拍视频^^";
    circleEntity.date = "2021-04-22 10:00";
    VideoData videoData = VideoData();
    videoData.coverImg = "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1591022950,3097001901&fm=26&gp=0.jpg";
    videoData.videoUrl = "https://v-cdn.zjol.com.cn/280443.mp4";
    circleEntity.videoData = videoData;
    circleEntity.commentCounts = 666;
    circleEntity.praiseCounts = 133;
    circleEntity.collectCounts = 255;

    circleEntity.comments = [];
    CommentEntity commentEntity = CommentEntity();
    commentEntity.username = "张三";
    commentEntity.content = "666，拍的不错~";
    circleEntity.comments.add(commentEntity);
    commentEntity = CommentEntity();
    commentEntity.username = "李四";
    commentEntity.content = "漂亮！Nice！Good！";
    circleEntity.comments.add(commentEntity);
    list.add(circleEntity);

    circleEntity = CircleEntity();
    circleEntity.id = 1;
    circleEntity.avatar =
        "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1909694165,3400923478&fm=26&gp=0.jpg";
    circleEntity.username = "火舞";
    circleEntity.content = "今天天气不错，心情挺好的，有没有小哥哥陪我出去玩啊？";
    circleEntity.date = "2021-03-26 10:00";
    circleEntity.images = [
      "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1591022950,3097001901&fm=26&gp=0.jpg",
      "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3434365774,3342884301&fm=26&gp=0.jpg",
      "https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1483731740,4186543320&fm=26&gp=0.jpg",
      "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1344528693,2427862478&fm=26&gp=0.jpg",
      "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1678495563,1310763494&fm=26&gp=0.jpg",
      "https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2069542074,3354686813&fm=26&gp=0.jpg"
    ];
    circleEntity.commentCounts = 3660;
    circleEntity.praiseCounts = 8601;
    circleEntity.collectCounts = 1988;

    circleEntity.comments = [];
    commentEntity = CommentEntity();
    commentEntity.username = "张三";
    commentEntity.content = "哇，你很漂亮啊~";
    circleEntity.comments.add(commentEntity);
    commentEntity = CommentEntity();
    commentEntity.username = "李四";
    commentEntity.content = "美女约不约，交个朋友呗~";
    circleEntity.comments.add(commentEntity);
    commentEntity = CommentEntity();
    commentEntity.username = "张三";
    commentEntity.content = "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈呵呵呵呵呵呵呵呵呵呵呵";
    commentEntity.replyUsername = "李四";
    circleEntity.comments.add(commentEntity);

    for (int i = 0; i < 10; i++) {
      list.add(circleEntity);
    }

    return list;
  }
}
