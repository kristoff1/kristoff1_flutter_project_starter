abstract class ImageProcessing {

  Future<String> getImage();

  Future<String> updateImage(
    String identifier,
    String oldImagePath,
    String? newTemporaryImagePath,
  );

  Future<String> addImage({
    required String identifier,
    required String temporaryImagePath,
  });

  Future<List<String>> getAllImages();

  Future<void> deletePreviousImages(List<String> originalPaths);

  Future<void> deleteAllImages();
}
