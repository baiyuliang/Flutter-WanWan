import 'package:dio/dio.dart';
import 'ResultData.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['errno'] != null) {
          //图片数据
          return ResultData(response.data['errno'],
              response.data['errmsg'], response.data['data']);
        } else {
          //新闻数据
          return ResultData(response.data['error_code'],
              response.data['reason'], response.data['result']);
        }
      }
    } catch (e) {
      print("ResponseInterceptor_Error>>" + e.toString() + option.path);
      return ResultData(response.statusCode, e.toString(), {});
    }
  }
}
