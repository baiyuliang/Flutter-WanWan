import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wanwan/model/circle_entity.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class VideoPlay extends StatefulWidget {
  VideoData videoData;

  VideoPlay({this.videoData}) : super();

  @override
  State<StatefulWidget> createState() {
    return MyVideoPlay();
  }
}

class MyVideoPlay extends State<VideoPlay> {
  IjkMediaController controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    play();
  }

  play() async {
    await controller.setNetworkDataSource(widget.videoData.videoUrl,
        autoPlay: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Center(
            child: IjkPlayer(
              mediaController: controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35, left: 20),
            child: GestureDetector(
              onTap: () => RouteUtil.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
