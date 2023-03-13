import 'package:camera/camera.dart';
import 'package:precious_cam/src/enum/resolution.dart';

const Map<Resolutions, ResolutionPreset> resolutionDictionary = {
  Resolutions.lowResolution : ResolutionPreset.medium,
  Resolutions.mediumResolution : ResolutionPreset.high,
  Resolutions.highResolution : ResolutionPreset.veryHigh,
};