

import 'package:cameratest/core/route_constant.dart';
import 'package:cameratest/feature/camera/binding/camera_binding.dart';
import 'package:cameratest/feature/camera/view/camera_page.dart';
import 'package:cameratest/feature/home/binding/home_binding.dart';
import 'package:cameratest/feature/home/view/home_page.dart';
import 'package:get/get.dart';

List<GetPage> getPages = [

  GetPage(
      name: RouteConstant.home,
      page: () =>  HomePage(),
      binding: HomeBinding()),
  GetPage(
      name: RouteConstant.camera,
      page: () =>  CameraExample(),
      binding: CameraBinding()),
];
