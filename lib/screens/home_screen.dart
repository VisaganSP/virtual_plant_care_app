import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/plant_controller.dart';
import '../widgets/plant_widget.dart';
import '../widgets/care_indicators.dart';

class HomeScreen extends StatelessWidget {
  final PlantController plantController = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Virtual Plant Care')),
      body: Column(
        children: [
          PlantWidget(),
          CareIndicators(),
          ElevatedButton(onPressed: plantController.waterPlant, child: Text('Water Plant')),
          ElevatedButton(onPressed: plantController.fertilizePlant, child: Text('Fertilize Plant')),
        ],
      ),
    );
  }
}
