import 'package:cameratest/core/route_constant.dart';
import 'package:cameratest/feature/cameraexp.dart';
import 'package:cameratest/feature/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to CameraView screen
            Get.toNamed(RouteConstant.camera);
            // Get.to(() => CameraExample());
            // Get.to(CameraExample);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text(
            'Camera',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }


}