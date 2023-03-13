abstract class DatabaseInterface {

  Future<void> configureDatabase(String dbName, int version,);

  Future<void> insertExplanationTopic(Map<String, dynamic> topic);

  Future<void> insertExplanationContent(Map<String, dynamic> content);

  Future<Map<String, dynamic>> updateContent(Map<String, dynamic> item);

  Future<Map<String, dynamic>> updateTopic(Map<String, dynamic> item);

  Future<void> deleteContent(String id);

  Future<void> deleteTopic(String topicId);

  Future<void> deleteAllData();

  Future<Map<String, dynamic>> getTopicById(String id);

  Future<List<Map<String, dynamic>>> getAllContentsByTopic(
      String topicId);

  //create a function that get all topics
  Future<List<Map<String, dynamic>>> getAllTopics();

  Future<List<Map<String, dynamic>>> getAllImagesPathOfATopic(
      String topicId);

  Future<List<Map<String, dynamic>>> getAllImagesPath();

  //create a function that counts all tags
  Future<int> countTopics();

  Future<Map<String, dynamic>> getContentById(String id);
}
