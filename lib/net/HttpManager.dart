import 'package:dio/dio.dart';
import '../commponets/Loading.dart';
import 'LoggerInterceptor.dart';
import 'ResponseInterceptor.dart';
import 'ResultData.dart';
import 'Url.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(
          new BaseOptions(baseUrl: Url.BASE_URL, connectTimeout: 15000));
      _dio.interceptors.add(new LoggerInterceptor());
      _dio.interceptors.add(new ResponseInterceptor());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Url.BASE_URL) {
        _dio.options.baseUrl = Url.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, {params, withLoading = false}) async {
    if (withLoading) {
      Loading.show("");
    }

    Response response;

    try {
      response = await _dio.get(api, queryParameters: params);
      if (withLoading) {
        Loading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, {params, withLoading = false}) async {
    if (withLoading) {
      Loading.show("");
    }

    Response response;

    try {
      response = await _dio.post(api, data: params);
      if (withLoading) {
        Loading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: -1);
  }
  return new ResultData(errorResponse.statusCode,errorResponse.statusMessage,{});
}
