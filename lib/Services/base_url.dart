import 'package:dio/dio.dart';

class DioBaseUrl{
  static Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
}