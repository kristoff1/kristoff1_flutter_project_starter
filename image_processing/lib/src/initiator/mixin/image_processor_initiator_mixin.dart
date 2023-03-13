import 'package:flutter/material.dart';
import 'package:image_processing/image_processing.dart';

mixin ImageProcessorInitiatorMixin<T extends StatefulWidget> on State<T> {

  @override
  void initState() {
    super.initState();
    _initiateImageProcessor();
  }

  void _initiateImageProcessor() {
    ImageProcessorInitiator initiator = ImageProcessorInitiator();
    initiator.initiateImageProcessing();
  }

}