import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_processing/image_processing.dart';
import 'package:image_processing/src/image_processing_impl.dart';

import 'design/margins.dart';
import 'design/overlay_button.dart';

class ImageProcessingCrop extends StatefulWidget {
  final Function(String) onPictureSelected;

  const ImageProcessingCrop({super.key, required this.onPictureSelected});

  @override
  State<ImageProcessingCrop> createState() => _ImageProcessingCropState();
}

class _ImageProcessingCropState extends State<ImageProcessingCrop> {
  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  bool allowed = true;
  File _originalPhoto = File('');
  ImageProcessing imageProcessing = ImageProcessingImpl();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      askPermission();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!allowed) {
      return _getRetryPermissionView();
    }
    if (_originalPhoto.path.isEmpty) {
      return _getPickImageView();
    }
    return _getMainView();
  }

  Widget _getPickImageView() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image,
                      size: 240, color: Colors.white70.withOpacity(0.7)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: OverlayButton(
                      text: 'Pick Image',
                      onTap: () {
                        _pickImage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              height: 40,
              margin: centristGap,
              child: OverlayButton(
                text: 'Cancel',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRetryPermissionView() {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: OverlayButton(
            text: 'Retry Permission Request',
            onTap: () {
              askPermission();
            },
          ),
        ),
      ),
    );
  }

  Widget _getMainView() {
    return Scaffold(
      body: Stack(
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
                    child: OverlayButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: OverlayButton(
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
      ),
    );
  }

  Future<void> _cropImage() async {
    final num scale = cropKey.currentState?.scale ?? 0;
    final Rect? area = cropKey.currentState?.area;
    if (area == null) {
      return;
    }
    final File sample = await ImageCrop.sampleImage(
        file: _originalPhoto, preferredSize: (2000 / scale).round());

    ImageCrop.cropImage(
      file: sample,
      area: area,
    ).then((value) {
      sample.delete();
      _originalPhoto.delete();
      widget.onPictureSelected(value.path);
      Navigator.pop(context);
    });
  }

  Future<void> askPermission() async {
    allowed = await ImageCrop.requestPermissions();
    setState(() {});
  }

  Future<void> _pickImage() async {
    final String filePath;

    try {
      filePath = await imageProcessing.getImage();
      setState(() {
        _originalPhoto = File(filePath);
      });
    } catch (e) {
      print(e);
    }
  }
}
