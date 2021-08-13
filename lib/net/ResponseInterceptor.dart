import 'package:dio/dio.dart';
import 'ResultData.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestOptions option = response.requestOptions;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['errno'] != null) {
          //图片数据
          response.data = ResultData(response.data['errno'],
              response.data['errmsg'], response.data['data']);
        } else {
          //新闻数据
          response.data = ResultData(response.data['error_code'],
              response.data['reason'], response.data['result']);
        }
      }
    } catch (e) {
      print("ResponseInterceptor_Error>>" + e.toString() + option.path);
      response.data = ResultData(response.statusCode, e.toString(), {});
    }
    handler.next(response);
  }
}
