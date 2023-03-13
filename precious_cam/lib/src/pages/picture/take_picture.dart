import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:precious_cam/precious_cam.dart';
import 'package:precious_cam/src/pages/picture/view_model/take_picture_contract.dart';
import 'package:precious_cam/src/pages/picture/view_model/take_picture_view_model.dart';
import 'package:precious_cam/src/pages/viewer/picture_review.dart';

///VIEW TO TAKE PICTURE
///DO NOT USE IF REQUIREMENT IS DRASTICALLY DIFFERENT
class TakePicture extends StatefulWidget {
  final Function(String temporaryPath) onPictureSaved;

  const TakePicture({super.key, required this.onPictureSaved});

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  final TakePictureContract viewModel = TakePictureViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<XFile?>(
        stream: viewModel.picturePageController.stream,
        builder: (BuildContext context, AsyncSnapshot<XFile?> snapshot) {
          XFile? resultPhoto = snapshot.data;
          if (resultPhoto == null) {
            return CameraCapture(
              resolution: Resolutions.mediumResolution,
              onPictureTaken: (XFile photo) {
                viewModel.showPicture(photo);
              },
            );
          }
          return PictureReview(
              photo: resultPhoto,
              onAcceptPicture: (String filePath) {
                Navigator.pop(context);
                widget.onPictureSaved(filePath);
              },
              onRetryPicture: () {
                viewModel.retryPicture();
              });
        },
      ),
    );
  }
}
