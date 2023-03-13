import 'package:dio/dio.dart';

abstract class Network {
  void configureNetwork({
    String baseUrl,
    int timeout,
  });

  Future<Response> get({
    required String path,
    required Map<String, dynamic> queryParams,
    Map<String, dynamic>? headers,
  });

  Future<Response> post({
    required String path,
    required Map<String, dynamic> queryParams,
    Map<String, dynamic>? headers,
  });

  Future<Response> patch({
    required String path,
    required Map<String, dynamic> queryParams,
    Map<String, dynamic>? headers,
  });
}
