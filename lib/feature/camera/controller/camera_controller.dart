import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraControllerX extends GetxController {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras; // List to store available cameras
  var isCameraInitialized = false.obs;
  var isFrontCamera = false.obs; // Track if front camera is selected

  @override
  void onInit() {
    super.onInit();
    initializeCamera(); // Initialize camera when the controller is created
  }

  // Method to initialize the camera
  Future<void> initializeCamera() async {
    // Get the list of available cameras
    cameras = await availableCameras();

    // Check if front camera is available and initialize it
    int selectedCameraIndex = isFrontCamera.value ? 1 : 0; // 0 for rear, 1 for front
    _controller = CameraController(
      cameras[selectedCameraIndex], // Use selected camera
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    // After initialization, mark as initialized
    isCameraInitialized.value = true;
    update(); // Notify listeners that initialization is complete
  }

  // Method to switch between front and rear cameras
  void toggleCamera() {
    isFrontCamera.value = !isFrontCamera.value; // Toggle camera
    isCameraInitialized.value = false; // Reset initialization status
    initializeCamera(); // Reinitialize with new camera
  }

  CameraController get controller => _controller;
  Future<void> get initializeController => _initializeControllerFuture;

  // Dispose the controller to free up resources
  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  // Method to capture the picture
  Future<XFile> takePicture() async {
    try {
      final picture = await _controller.takePicture();
      return picture;
    } catch (e) {
      rethrow;
    }
  }
}
