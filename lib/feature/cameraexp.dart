/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CameraControllerX extends GetxController {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();  // Initialize camera when the controller is created
  }

  // Method to initialize the camera
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[0], // Use the first available camera
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    update();  // Notify listeners that initialization is complete
  }

  CameraController get controller => _controller;
  Future<void> get initializeController => _initializeControllerFuture;
}

class CameraExample extends StatelessWidget {
  const CameraExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the CameraControllerX instance using GetX
    final CameraControllerX controller = Get.put(CameraControllerX());

    return Scaffold(
      appBar: AppBar(title: Text('Camera Example')),
      body: Center(
        child: GetBuilder<CameraControllerX>(
          init: controller,
          builder: (_) {
            return FutureBuilder<void>(
              future: controller.initializeController,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Camera preview is ready
                  return CameraPreview(controller.controller);
                } else {
                  // Show loading indicator while the camera is initializing
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            // Ensure that the camera is initialized before taking a picture
            await controller.initializeCamera();

            // Get temporary directory and save path for the picture
            final directory = await getTemporaryDirectory();
            final path = join(directory.path, '${DateTime.now()}.png');

            // Capture the picture
            XFile picture = await controller.controller.takePicture();

            // Save the picture to the desired path
            await picture.saveTo(path);

            // Use Get.to() for navigation to display the captured picture
            Get.to(() => DisplayPictureScreen(imagePath: path));
          } catch (e) {
            if (kDebugMode) {
              print(e); // Log the error if something goes wrong
            }
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Picture')),
      body: Center(
        child: Image.file(File(imagePath)), // Display the image
      ),
    );
  }
}*/

/*void main() {
  runApp(MaterialApp(
    home: CameraExample(),
  ));
}*/
