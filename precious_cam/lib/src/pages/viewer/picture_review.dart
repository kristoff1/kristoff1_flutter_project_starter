import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:precious_cam/src/atoms/camera_overlay_button.dart';

class PictureReview extends StatefulWidget {
  final XFile photo;
  final Function(String path) onAcceptPicture;
  final VoidCallback onRetryPicture;

  const PictureReview({
    super.key,
    required this.photo,
    required this.onAcceptPicture,
    required this.onRetryPicture,
  });

  @override
  State<PictureReview> createState() => _PictureReviewState();
}

class _PictureReviewState extends State<PictureReview> {

  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  bool allowed = true;
  File _originalPhoto = File('');


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      askPermission();
    });
    _originalPhoto = File(widget.photo.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!allowed) {
      return _getRetryPermissionView();
    }
    return _getMainView();
  }

  Center _getRetryPermissionView() {
    return Center(
      child: Container(
        color: Colors.black,
        child: CameraOverlayButton(
          text: 'Retry Permission Request',
          onTap: () {
            askPermission();
          },
        ),
      ),
    );
  }

  Widget _getMainView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black87,
        ),
        Crop.file(_originalPhoto, key: cropKey, aspectRatio: 1),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CameraOverlayButton(
                      onTap: () {
                        widget.onRetryPicture();
                      },
                      text: 'Retry'),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CameraOverlayButton(
                      onTap: () async {
                        await _cropImage();
                      },
                      text: 'Done'),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _cropImage() async {
    final num scale = cropKey.currentState?.scale ?? 0;
    final Rect? area = cropKey.currentState?.area;
    if(area == null) {
      return;
    }
    final File sample = await ImageCrop.sampleImage(file: _originalPhoto, preferredSize: (2000 / scale).round());

    final File file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _originalPhoto.delete();
    widget.onAcceptPicture(file.path);
  }

  Future<void> askPermission() async {
    allowed = await ImageCrop.requestPermissions();
    setState(() {});
  }

}
