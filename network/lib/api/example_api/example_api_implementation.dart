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
  Future<Map<String, dynamic>> getDetail(String id) async {
    try {
      ///TODO SET THE PATH AND QUERY YOURSELF THIS IS JUST AN EXAMPLE
      Response response = await interface.get(
        path: '/example/path',
        queryParams: {'key': id},
      );
      return _convertResponseToJSON(response);
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
  Future<List<Map<String, dynamic>>> getList(int page) async {
    ///TODO SET THE PATH AND QUERY YOURSELF THIS IS JUST AN EXAMPLE
    try {
      Response response = await interface.get(
        path: '/put/the/path/here',
        queryParams: {'example-query': page},
      );
      return _convertListResponseToJSON(response);
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

  Map<String, dynamic> _convertResponseToJSON(Response response) {
    try {
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      throw Exception('Network Exception');
    }
  }

  List<Map<String, dynamic>> _convertListResponseToJSON(Response response) {
    try {
      return List<Map<String, dynamic>>.from(response.data)
          .map((json) => Map<String, dynamic>.from(json))
          .toList();
    } catch (e) {
      ///TODO HANDLE ERROR HERE
      throw Exception();
    }
  }
}
