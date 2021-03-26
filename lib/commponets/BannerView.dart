import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Toast.dart';

class BannerView extends StatefulWidget {
  List<String> images;
  double height;
  EdgeInsets margin;
  double border;
  Function onTap;

  BannerView({this.images, this.height, this.margin, this.border, this.onTap})
      : super();

  @override
  State<StatefulWidget> createState() {
    return MyBannerView();
  }
}

class MyBannerView extends State<BannerView> {
  int curIndex = 0;
  PageController pageController = PageController();
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (t) {
      curIndex++;
      pageController.animateToPage(
        curIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBannerView();
  }

  buildBannerView() {
    return Container(
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [buildPageView(), buildIndicator()],
      ),
    );
  }

  buildPageView() {
    var length = widget.images.length;
    return PageView.builder(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          if (index == 0) {
            curIndex = length;
          } else {
            curIndex = index;
          }
        });
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Toast.show((index % length).toString());
          },
          child: Container(
            margin: widget.margin,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.border ?? 0),
              child: Image.network(
                widget.images[index % length],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  buildIndicator() {
    var length = widget.images.length;
    return Positioned(
      bottom: 15,
      child: Row(
        children: widget.images.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipOval(
              child: Container(
                width: s == widget.images[curIndex % length] ? 8 : 6,
                height: s == widget.images[curIndex % length] ? 8 : 6,
                color: s == widget.images[curIndex % length]
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
