import 'package:flutter/material.dart';
import 'package:precious_cam/precious_cam.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black87,
        child: CaptureButton(
          onClick: () {},
        ),
      ),
    );
  }

}