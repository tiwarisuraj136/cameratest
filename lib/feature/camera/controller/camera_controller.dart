import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraControllerX extends GetxController {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var isFrontCamera = false.obs;
  var capturedPhotoPath = ''.obs; // Store the captured photo path

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    int selectedCameraIndex = isFrontCamera.value ? 1 : 0;
    _controller = CameraController(
      cameras[selectedCameraIndex],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    isCameraInitialized.value = true;
    update();
  }

  void toggleCamera() {
    isFrontCamera.value = !isFrontCamera.value;
    isCameraInitialized.value = false;
    initializeCamera();
  }

  CameraController get imagePreviewController => _controller;
  Future<void> get initializeController => _initializeControllerFuture;

  Future<void> takePicture() async {
    try {
      final picture = await _controller.takePicture();
      capturedPhotoPath.value = picture.path; // Update the photo path
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
