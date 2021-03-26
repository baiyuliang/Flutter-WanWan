import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader {
  static homeHeader() {
    return WaterDropHeader(
      waterDropColor: Colors.white,
      idleIcon: Icon(
        Icons.refresh,
        size: 15,
        color: Colors.red,
      ),
      refresh: SizedBox(
        width: 25.0,
        height: 25.0,
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? const CupertinoActivityIndicator()
            : Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  backgroundColor: Colors.white,
                ),
              ),
      ),
      complete: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.done,
            color: Colors.white,
            size: 15,
          ),
          Container(
            width: 15.0,
          ),
          Text(
            "刷新完成",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  static homeFooter() {
    return CustomFooter(builder: (BuildContext context, LoadStatus mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text("上拉加载");
      } else if (mode == LoadStatus.loading) {
        body = Container(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: Colors.red,
          ),
        );
      } else if (mode == LoadStatus.failed) {
        body = Text("加载失败");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("上拉加载");
      } else {
        body = Text("没有更多数据~");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    });
  }
}
