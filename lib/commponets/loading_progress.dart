import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingProgress extends StatefulWidget {
  final Widget progress;
  final Color bgColor;
  final DialogLoadingController controller;

  const LoadingProgress(
      {Key key, this.progress, this.bgColor, @required this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingProgressState();
  }
}

class LoadingProgressState extends State<LoadingProgress> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.controller.isShow) {
        //todo
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    widget.controller?.isShow = false;
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: widget.progress ??
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0x99000000),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3)
              ],
            ),
          ),
    );
  }
}

class DialogLoadingController extends ChangeNotifier {
  bool isShow = true;

  dismissDialog() {
    isShow = false;
    notifyListeners();
  }
}
