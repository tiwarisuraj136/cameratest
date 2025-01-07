import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cameratest/feature/camera/controller/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// class CameraExample extends StatelessWidget {
class CameraExample extends GetView<CameraControllerX>{
  const CameraExample({super.key});

  @override
  Widget build(BuildContext context) {
    // final cameraController = Get.put(CameraControllerX()); // Instantiate controller

    return Scaffold(
      appBar: AppBar(title: const Text('Camera Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar to display captured photo
          Obx(() {
            return CircleAvatar(
              radius: 50,
              backgroundImage: controller.capturedPhotoPath.value.isNotEmpty
                  ? FileImage(File(controller.capturedPhotoPath.value))
                  : null,
              child: controller.capturedPhotoPath.value.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : null,
            );
          }),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (!controller.isCameraInitialized.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return CameraPreview(controller.imagePreviewController);
            }),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'capture',
              child: const Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  // Capture and save the picture
                  final directory = await getTemporaryDirectory();
                  final path = join(directory.path, '${DateTime.now()}.png');

                  await controller.takePicture();

                  if (controller.capturedPhotoPath.value.isNotEmpty) {
                    debugPrint('Photo saved at ${controller.capturedPhotoPath.value}');
                    debugPrint('Photo saved at ====> $path');
                  }
                } catch (e) {
                  debugPrint('Error capturing photo: $e');
                }
              },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'switch',
              child: const Icon(Icons.switch_camera),
              onPressed: () => controller.toggleCamera(),
            ),
          ],
        ),
      ),
    );
  }
}
