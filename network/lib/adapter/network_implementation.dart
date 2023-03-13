import 'package:dio/dio.dart';
import 'dart:developer' as developer;

import 'network.dart';

class NetworkImplementation implements Network {
  ///TODO SET DEFAULT URL HERE
  static const String defaultBaseUrl = 'www.default.com';
  static const int defaultTimeout = 7000;
  late final Dio dio;

  NetworkImplementation()
      : dio = Dio(BaseOptions(
          baseUrl: defaultBaseUrl,
          connectTimeout: defaultTimeout,
        )) {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        return handler.next(options);
      }, onError: (DioError e, handler) {
        switch (e.type) {
          case DioErrorType.connectTimeout:
            e.error = 'Connection Timeout';
            break;
          case DioErrorType.sendTimeout:
            e.error = 'Connection Timeout';
            break;
          case DioErrorType.receiveTimeout:
            e.error = 'Connection Problem';
            break;
          case DioErrorType.response:
            e.error = 'Connection Problem';
            break;
          case DioErrorType.cancel:
            e.error = 'Connection Problem';
            break;
          case DioErrorType.other:
            e.error = 'Connection Problem';
            break;
        }
        developer.log('Error ${e.response?.statusCode?.toString() ?? ''}');
        return handler.next(e);
      }),
    );
  }

  @override
  void configureNetwork({String? baseUrl, int? timeout}) {
    dio.options = BaseOptions(
      baseUrl: baseUrl ?? defaultBaseUrl,
      connectTimeout: timeout ?? defaultTimeout,
    );
  }

  @override
  Future<Response> get(
      {required String path,
      required Map<String, dynamic> queryParams,
      Map<String, dynamic>? headers}) {
    return dio.get(
      path,
      queryParameters: queryParams,
      options: Options(
        headers: headers ?? _getDefaultHeader(),
      ),
    );
  }

  @override
  Future<Response> post(
      {
        required String path,
      required Map<String, dynamic> queryParams,
      Map<String, dynamic>? headers}) {
    return dio.post(
      path,
      data: queryParams,
      options: Options(
        headers: headers ?? _getDefaultHeader(),
      ),
    );
  }

  @override
  Future<Response> patch({
    required String path,
    required Map<String, dynamic> queryParams,
    Map<String, dynamic>? headers,
  }) {
    return dio.patch(
      path,
      data: queryParams,
      options: Options(
        headers: headers ?? _getDefaultHeader(),
      ),
    );
  }

  Map<String, dynamic> _getDefaultHeader() {
    ///TODO SET DEFAULT HEADER HERE
    return {};
  }
}
