import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wanwan/utils/RouteUtil.dart';

// ignore: must_be_immutable
class GalleryImagePreview extends StatefulWidget {
  List<String> galleryItems;
  int index;

  GalleryImagePreview({this.galleryItems, this.index}) : super();

  @override
  MyGalleryImagePreview createState() => MyGalleryImagePreview();
}

class MyGalleryImagePreview extends State<GalleryImagePreview> {
  PageController pageController;
  int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.index;
    pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: GestureDetector(
              onTap: () => RouteUtil.pop(context),
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.galleryItems[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 1.2,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
                itemCount: widget.galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
                // backgroundDecoration: widget.backgroundDecoration,
                pageController: pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              )),
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
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            "${pageIndex + 1}/${widget.galleryItems.length}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }
}
