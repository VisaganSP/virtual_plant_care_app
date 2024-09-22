import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plant_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPlant(Plant plant) async {
    await _firestore.collection('plants').add(plant.toJson());
  }

  Future<List<Plant>> fetchPlants() async {
    final snapshot = await _firestore.collection('plants').get();
    return snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList();
  }

  Future<void> updatePlant(Plant plant) async {
    await _firestore.collection('plants').doc(plant.id).update(plant.toJson());
  }

  Future<void> addPlants() async {
    List<Plant> plants = [
      Plant(
        name: "Sahara Cactus",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/cactus_growth_one.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 20.0,
        sunlightRequirement: 80.0,
        fertilizerRequirement: 20.0,
      ),
      Plant(
        name: "Flower Cactus",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/cactus_growth_two.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 10.0,
        sunlightRequirement: 90.0,
        fertilizerRequirement: 10.0,
      ),
      Plant(
        name: "Lily Flower",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/flower_plant_growth.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 70.0,
        sunlightRequirement: 100.0,
        fertilizerRequirement: 30.0,
      ),
      Plant(
        name: "Rose Flower",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/flower_plant_growth2.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 50.0,
        sunlightRequirement: 80.0,
        fertilizerRequirement: 10.0,
      ),
      Plant(
        name: "Maize Plant",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/maize_plant_growth.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 10.0,
        sunlightRequirement: 50.0,
        fertilizerRequirement: 60.0,
      ),
      Plant(
        name: "Snake Plant",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/snake_plant_growth.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 10.0,
        sunlightRequirement: 10.0,
        fertilizerRequirement: 10.0,
      ),
      Plant(
        name: "Tomato Plant",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/tomato_plant_growth.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 20.0,
        sunlightRequirement: 90.0,
        fertilizerRequirement: 10.0,
      ),
      Plant(
        name: "Mango Tree",
        waterLevel: 100.0,
        fertilizerLevel: 100.0,
        sunlightLevel: 100.0,
        growth: 0.0,
        lottieFile: 'assets/animations/tree_growth.json',
        lastWatered: DateTime.now(),
        lastFertilized: DateTime.now(),
        waterRequirement: 50.0,
        sunlightRequirement: 90.0,
        fertilizerRequirement: 40.0,
      ),
    ];

    for (var plant in plants) {
      await _firestore.collection('plants').add(plant.toJson());
    }
  }
}
