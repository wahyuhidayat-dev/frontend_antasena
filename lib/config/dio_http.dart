import 'package:dio/dio.dart';

import '../shared/const.dart';

class DioHttp {
  static Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  static Dio request = Dio(BaseOptions(
      //connectTimeout: 5000,
      // receiveTimeout: 5000,
      baseUrl: base_url,
      headers: headers));
}
