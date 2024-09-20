import 'package:get/get.dart';

import '../models/plant_model.dart';
import '../services/firebase_service.dart';

class PlantController extends GetxController {
  var plant = Plant(
          name: "Cactus",
          lastWatered: DateTime.now(),
          lastFertilized: DateTime.now())
      .obs;

  void waterPlant() {
    plant.update((val) {
      val?.waterPlant();
      FirebaseService.updatePlantData(val!);
    });
  }

  void fertilizePlant() {
    plant.update((val) {
      val?.fertilizePlant();
      FirebaseService.updatePlantData(val!);
    });
  }

// Other state management logic...
}
