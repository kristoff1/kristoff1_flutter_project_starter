import 'package:dependency_injection/dependency_injection.dart';
import 'dart:developer' as developer;

import 'package:image_processing/image_processing.dart';
import 'package:image_processing/src/image_processing_impl.dart';

class ImageProcessorInitiator {
  final Injector _injector = Injector.instance;

  void initiateImageProcessing() {
    ImageProcessing imageProcessing() {
      developer.log('Image Processing Initiated');
      return ImageProcessingImpl();
    }

    _injector.registerDependency<ImageProcessing>(imageProcessing);

  }
}