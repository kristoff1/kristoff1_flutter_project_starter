abstract class ExampleApi {

  Future<List<Map<String, dynamic>>> getList(int page);
  Future<Map<String, dynamic>> getDetail(String id);

}
