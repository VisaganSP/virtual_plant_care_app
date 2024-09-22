import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/widgets/care_indicators.dart';

import '../controllers/plant_controller.dart';
import '../widgets/plant_widget.dart';
import 'plant_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  final PlantController plantController = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
            () => Text('Growing ${plantController.selectedPlant.value.name}')),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Navigate to plant selection screen
              await plantController.sendImmediateNotification();
              Get.to(() => PlantSelectionScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        // Dynamic background color based on time of day
        return Container(
          color: plantController.backgroundColor.value,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PlantWidget(
                  plant: plantController.selectedPlant.value,
                ),
              ),
              CareIndicators(
                plant: plantController.selectedPlant.value,
                backgroundColor: plantController.backgroundColor.value,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue, // Button color
                ),
                onPressed: plantController.canWater
                    ? () => plantController.waterPlant(context)
                    : null,
                child:
                    Text('Water ${plantController.selectedPlant.value.name}'),
              ),
              SizedBox(height: 10), // Space between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green, // Button color
                ),
                onPressed: plantController.canFertilize
                    ? () => plantController.fertilizePlant(context)
                    : null,
                child: Text(
                    'Fertilize ${plantController.selectedPlant.value.name}'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
