import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/plant_controller.dart';

class CareIndicators extends StatelessWidget {
  final PlantController plantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double waterLevel = plantController.plant.value.waterLevel;
      double sunlightLevel = plantController.plant.value.sunlightLevel;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.opacity, size: 50, color: Colors.blue),
              Text('Water: ${waterLevel.toStringAsFixed(0)}%'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.wb_sunny, size: 50, color: Colors.orange),
              Text('Sunlight: ${sunlightLevel.toStringAsFixed(0)}%'),
            ],
          ),
        ],
      );
    });
  }
}
