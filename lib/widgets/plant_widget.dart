import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/plant_controller.dart';

class PlantWidget extends StatelessWidget {
  final PlantController plantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double growth = plantController.plant.value.growth;
      return AnimatedContainer(
        height: growth + 100,
        width: growth + 100,
        duration: Duration(seconds: 2),
        child: Image.asset('assets/images/plant.png'), // Display plant image
      );
    });
  }
}
