import 'package:flutter/cupertino.dart';
import 'package:wanwan/commponets/loading_progress.dart';

import 'BaseStatefulWidget.dart';

abstract class BaseState<T> extends State<BaseStatefulWidget> {
  DialogLoadingController _dialogLoadingController;

  showLoading({
    Widget progress,
    Color bgColor,
  }) {
    if (_dialogLoadingController == null) {
      _dialogLoadingController = DialogLoadingController();
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (ctx, animation, secondAnimation) {
            return LoadingProgress(
              controller: _dialogLoadingController,
              progress: progress,
              bgColor: bgColor,
            );
          }));
    }
  }

  dismissLoading() {
    _dialogLoadingController?.dismissDialog();
    _dialogLoadingController = null;
  }

}
