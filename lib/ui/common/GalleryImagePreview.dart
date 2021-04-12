import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wanwan/utils/RouteUtil.dart';

class GalleryImagePreview extends StatefulWidget {
  List<String> galleryItems;
  int index;

  GalleryImagePreview({this.galleryItems, this.index}) : super();

  @override
  State<StatefulWidget> createState() {
    return MyGalleryImagePreview();
  }
}

class MyGalleryImagePreview extends State<GalleryImagePreview> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
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
                // onPageChanged: onPageChanged,
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
        )
      ],
    );
  }
}
