import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:precious_cam/src/atoms/capture_button.dart';
import 'package:precious_cam/src/enum/resolution.dart';
import 'package:precious_cam/src/enum/resolution_dictionary.dart';


///CAPTURE PAGE
///CHANGE DESIGN IF NEEDED
///FRONT AND BACK CAMERA CAN BE ADJUSTED WITH ADDITIONAL ENUMS
///BUTTON IN [CaptureButton]
class CameraCapture extends StatefulWidget {
  final Resolutions resolution;
  final Function(XFile) onPictureTaken;

  const CameraCapture({
    super.key,
    required this.resolution,
    required this.onPictureTaken,
  });

  @override
  State<CameraCapture> createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> with WidgetsBindingObserver {

  CameraController? _controller;
  String? error;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_){
      initiateCameraAndController();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initiateCameraAndController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getMainBody();
  }

  Widget _getMainBody() {
    CameraController? currentController = _controller;
    if(error != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.warning_rounded, color: Colors.deepOrange, size: 40),
          const SizedBox(height: 12),
          Text(error ?? ''),
        ],
      );
    } else if(currentController == null) {
      return Container(
        color: Colors.black87,
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black,
        ),
        CameraPreview(currentController),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 180,
            alignment: Alignment.center,
            color: Colors.black87,
            child: CaptureButton(
              onClick: () {
                _controller?.takePicture().then((value) {
                  widget.onPictureTaken(value);
                });
              },
            ),
          ),
        ),

      ],
    );
  }

  Future<void> initiateCameraAndController() async {
    _disposeController();
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription backCamera = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back);
    CameraController resultController = CameraController(
      backCamera,
      enableAudio: false,
      resolutionDictionary[widget.resolution] ?? ResolutionPreset.medium,
    );
    try {
      await resultController.initialize();
      setState(() {
        _controller = resultController;
      });
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          setState(() {
            error = 'Camera Denied';
          });
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          setState(() {
            error = 'Camera Denied';
          });
          break;
        case 'CameraAccessRestricted':
          setState(() {
            error = 'Camera Denied';
          });
          break;
        case 'AudioAccessDenied':
          //showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
          //showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
        // iOS only
          //showInSnackBar('Audio access is restricted.');
          break;
        default:
          //_showCameraException(e);
          break;
      }
    } catch(e) {
      print(e);
    }
  }

  void _disposeController() {
    if(_controller != null) {
      _controller?.dispose();
    }
  }
}
