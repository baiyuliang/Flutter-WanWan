import 'package:flutter_easyloading/flutter_easyloading.dart';

bool loadingStatus = false;

class Loading {

  static show(String msg) {
    EasyLoading.show(status: msg,maskType: EasyLoadingMaskType.black);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
