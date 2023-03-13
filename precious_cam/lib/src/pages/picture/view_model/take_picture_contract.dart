import 'package:camera/camera.dart';
import 'package:rxdart/rxdart.dart';

abstract class TakePictureContract {

  late final BehaviorSubject<XFile?> picturePageController;

  Future<void> showPicture(XFile photo);
  Future<void> retryPicture();

}