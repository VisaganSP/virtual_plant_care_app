import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/plant_controller.dart';
import '../models/plant_model.dart';

class PlantSelectionScreen extends StatelessWidget {
  final PlantController plantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a Plant to grow"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showInfoPopup(context);
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          // childAspectRatio: 0.7,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: plantController.plants.length,
        itemBuilder: (context, index) {
          final plant = plantController.plants[index];
          return GestureDetector(
            onLongPress: () {
              // Show detailed information in a dialog
              _showPlantDetails(context, plant);
            },
            onTap: () {
              // Select the plant and return to home screen
              plantController.selectPlant(plant);
              Get.back(); // Navigate back to the home screen
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: SizedBox(
                      height: 100,
                      child: Lottie.asset(
                        plant.lottieFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        plant.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPlantDetails(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(plant.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Water Requirement: ${plant.waterRequirement}%"),
              Text("Sunlight Requirement: ${plant.sunlightRequirement}%"),
              Text("Fertilizer Requirement: ${plant.fertilizerRequirement}%"),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInfoPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 300),
          child: AlertDialog(
            title: Text("Info"),
            content: Text(
              "Long press on a plant card to view its growth details.",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
