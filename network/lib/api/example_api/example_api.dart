import 'package:dio/dio.dart';

abstract class ExampleApi {

  Future<Response> getList(int page);
  Future<Response> getDetail(String id);

}
