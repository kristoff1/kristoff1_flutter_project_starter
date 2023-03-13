import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:image_processing/image_processing.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:developer' as developer;

class ImageProcessingImpl extends ImageProcessing {
  final ImagePicker _picker = ImagePicker();

  ///GET IMAGE FROM USER'S LOCAL GALLERY
  @override
  Future<String> getImage() async {
    XFile? file =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (file != null) {
      return file.path;
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> updateImage(
      String identifier,
      String oldImagePath,
      String? newTemporaryImagePath,
      ) async {
    ///We dont need to delete cache image, because it will be gone anyway
    developer.log('Image will be saved $newTemporaryImagePath');

    ///Clean previous images that contains the identifier
    String pathToBeReplaced = oldImagePath;

    ///See if previous file exists
    bool fileExist = await File(pathToBeReplaced).exists();
    if (fileExist) {
      File(pathToBeReplaced).deleteSync();
      developer.log('$pathToBeReplaced Deleted');
    }

    ///Save Files
    if (newTemporaryImagePath != null && newTemporaryImagePath.isNotEmpty) {
      developer.log('Replacing $pathToBeReplaced with $newTemporaryImagePath');
      return await addImage(
        identifier: identifier,
        temporaryImagePath: newTemporaryImagePath,
      );
    }
    return '';
  }

  ///ADD IMAGE IN USER'S LOCAL PATH
  @override
  Future<String> addImage({
    required String identifier,
    required String temporaryImagePath,
  }) async {
    String permanentImagePath = await _makeImagePath(identifier);
    await _saveImageToAppDirectory(
        identifier, temporaryImagePath, permanentImagePath);
    await deletePreviousImages([temporaryImagePath]);
    developer.log('$temporaryImagePath has been deleted');
    return permanentImagePath;
  }

  ///CREATE IMAGE PATH FOR [addImage] method
  Future<String> _makeImagePath(String id) async {
    String randomSuffix = Random().nextInt(100).toString();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String imagePath = '${appDocDir.path}/$id-$randomSuffix.png';
    developer.log('new image path: $imagePath');
    return imagePath;
  }

  ///SAVE IMAGE TO PATH FOR [addImage] method after [_makeImagePath] executed
  Future<void> _saveImageToAppDirectory(
      String id, String temporaryPath, String permanentPath) async {
    //For New Items, we'll copy the image from temp file to new file
    //For previously existing image, we'll move them to the new image path
    //We handle both cases with the same function for the sake of efficiency
    //image variable represents current image
    File image = File(temporaryPath);
    developer.log(
        'Image Original Path: $temporaryPath - Destination Path: $permanentPath');
    //We copy the image to a new location
    image.copySync(permanentPath);
  }

  ///GET ALL IMAGES
  @override
  Future<List<String>> getAllImages() {
    //We get all the images in the app directory
    return getApplicationDocumentsDirectory().then((Directory directory) {
      List<FileSystemEntity> files = directory.listSync();
      List<String> images = [];
      for (FileSystemEntity file in files) {
        if (file.path.endsWith('.png')) {
          images.add(file.path);
        }
      }
      return images;
    });
  }

  ///DELETE ALL IMAGES
  ///FOR ONE IMAGE DELETION, JUST PUT THE IMAGE PATH IN THE ARRAY
  ///EXAMPLE: [imagePath]
  @override
  Future<void> deletePreviousImages(List<String> originalPaths) async {
    //We delete the old image
    for (int i = 0; i < originalPaths.length; i++) {
      if (originalPaths[i].isNotEmpty) {
        File image = File(originalPaths[i]);
        //We delete the old image
        image.deleteSync();
        developer.log('IMAGE ${originalPaths[i]} HAS BEEN DELETED');
      }
    }
  }

  ///COMPLETE IMAGE CLEANUP
  @override
  Future<void> deleteAllImages() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocDir.listSync();
    for (FileSystemEntity file in files) {
      if (file.path.endsWith('.png')) {
        file.deleteSync();
      }
    }
  }
}
