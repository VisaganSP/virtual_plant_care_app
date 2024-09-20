import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plant_model.dart';

class FirebaseService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> initializeFirebase() async {
    // Firebase initialization logic here
  }

  static Future<void> updatePlantData(Plant plant) async {
    await firestore.collection('plants').doc('plantId').set({
      'name': plant.name,
      'waterLevel': plant.waterLevel,
      'sunlightLevel': plant.sunlightLevel,
      'growth': plant.growth,
    });
  }

// Other Firebase functions...
}
