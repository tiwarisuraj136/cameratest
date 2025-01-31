import 'package:camera/camera.dart';
import 'package:cameratest/core/display_camera.dart';
import 'package:cameratest/feature/camera/controller/camera_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraExample extends StatelessWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('Camera Example')),
      body: GetBuilder<CameraControllerX>(
        init: CameraControllerX(), // Initialize the CameraControllerX
        builder: (controller) {
          return Obx(() {
            if (!controller.isCameraInitialized.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // Camera preview is ready after initialization
            return CameraPreview(controller.cameraClickController);
          });
        },
      ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,  // Align the FAB at the bottom center
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Optional: Add some bottom padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Center the row horizontally
              children: [
                // Floating action button to take a picture
                FloatingActionButton(
                  heroTag: 'camera',  // Optional: To avoid hero tag conflicts
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    try {
                      final controller = Get.find<CameraControllerX>(); // Get the controller

                      // Ensure that the camera is initialized before taking a picture
                      await controller.initializeCamera();

                      // Get temporary directory and save path for the picture
                      final directory = await getTemporaryDirectory();
                      final path = join(directory.path, '${DateTime.now()}.png');

                      // Capture the picture
                      XFile picture = await controller.takePicture();

                      // Save the picture to the desired path
                      await picture.saveTo(path);

                      // Use Get.to() for navigation to display the captured picture
                      Get.to(() => DisplayPictureScreen(imagePath: path));
                    } catch (e) {
                      if (kDebugMode) {
                        print('Error: $e'); // Log the error if something goes wrong
                      }
                    }
                  },
                ),
                const SizedBox(width: 10), // Space between the buttons
                // Floating action button to toggle between front and rear camera
                FloatingActionButton(
                  heroTag: 'switch',  // Optional: To avoid hero tag conflicts
                  child: const Icon(Icons.switch_camera),
                  onPressed: () {
                    final controller = Get.find<CameraControllerX>();
                    controller.toggleCamera(); // Switch between front and rear camera
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}