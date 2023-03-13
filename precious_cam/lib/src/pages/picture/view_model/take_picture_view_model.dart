import 'package:camera/camera.dart';
import 'package:precious_cam/src/pages/picture/view_model/take_picture_contract.dart';
import 'package:rxdart/rxdart.dart';

class TakePictureViewModel extends TakePictureContract {

  XFile? currentPhoto;

  TakePictureViewModel() {
    picturePageController = BehaviorSubject<XFile?>.seeded(null);
  }

  @override
  Future<void> retryPicture() async {
    currentPhoto = null;
    picturePageController.add(currentPhoto);
  }

  @override
  Future<void> showPicture(XFile photo) async {
    currentPhoto = photo;
    picturePageController.add(currentPhoto);
  }

}