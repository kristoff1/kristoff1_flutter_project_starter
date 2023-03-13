import 'package:dio/dio.dart';
import 'package:network/adapter/network.dart';
import 'package:network/api/example_api/example_api.dart';
import 'package:network/exceptions/under_maintenance_exception.dart';

class ExampleApiImplementation extends ExampleApi {
  final Network interface;

  ExampleApiImplementation({
    required this.interface,
  });

  @override
  Future<Response> getDetail(String id) async {
    try {
      ///TODO SET THE PATH AND QUERY YOURSELF THIS IS JUST AN EXAMPLE
      Response response = await interface.get(
        path: '/example/path',
        queryParams: {'key': id},
      );
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 503) {
        throw UnderMaintenanceException('Under Maintenance');
      }
      ///TODO PLACE YOUR EXCEPTION ERROR
      throw Exception('Network Exception');
    } catch (e) {
      ///TODO ADD YOUR OWN EXCEPTION
      throw Exception('Unknown Exception');
    }
  }

  @override
  Future<Response> getList(int page) async {
    try {
      Response response = await interface.get(
        path: '/api/nl/collection',
        queryParams: {'p': page},
      );
      return response;
    } on DioError catch(e) {
      if (e.response?.statusCode == 503) {
        throw UnderMaintenanceException('Under Maintenance');
      }
      ///TODO PLACE YOUR EXCEPTION ERROR
      throw Exception('Network Exception');
    }
    catch (e) {
      ///TODO ADD YOUR OWN EXCEPTION
      throw Exception('Unknown Exception');
    }
  }
}
