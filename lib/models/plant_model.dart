class Plant {
  String? id;
  String name;
  double waterLevel; // Current water level of the plant (0-100)
  double fertilizerLevel; // Current fertilizer level of the plant (0-100)
  double sunlightLevel; // Current sunlight level of the plant (0-100)
  double growth; // Represents overall growth (0-100)
  String lottieFile; // Path to the Lottie animation file
  DateTime lastWatered; // Timestamp of the last watering
  DateTime lastFertilized; // Timestamp of the last fertilization
  double waterRequirement; // Specific water requirement for the plant
  double sunlightRequirement; // Specific sunlight requirement for the plant
  double fertilizerRequirement; // Specific fertilizer requirement for the plant

  Plant({
    this.id,
    required this.name,
    this.waterLevel = 0.0,
    this.fertilizerLevel = 0.0,
    this.sunlightLevel = 100.0,
    this.growth = 0.0,
    required this.lottieFile,
    required this.lastWatered,
    required this.lastFertilized,
    required this.waterRequirement,
    required this.sunlightRequirement,
    required this.fertilizerRequirement,
  });

  bool canWater() {
    // Check if the current water level is below the requirement
    return waterLevel < waterRequirement;
  }

  bool canFertilize() {
    // Check if the growth level is below the fertilizer requirement
    return fertilizerLevel < fertilizerRequirement;
  }

  // Water the plant
  void waterPlant() {
    if (canWater()) {
      waterLevel += 30.0; // Increase water level
      growth += 2.0; // Increase growth when watered
      lastWatered = DateTime.now(); // Update last watered time
      if (waterLevel > 100.0) waterLevel = 100.0;
      if (growth > 100.0) growth = 100.0; // Ensure growth does not exceed 100
    }
  }

  // Fertilize the plant to increase growth
  void fertilizePlant() {
    if (canFertilize()) {
      fertilizerLevel += 10.0;
      growth += 2.0; // Increase growth when fertilized
      lastFertilized = DateTime.now(); // Update last fertilized time
      if (fertilizerLevel > 100.0) fertilizerLevel = 100.0;
      if (growth > 100.0) growth = 100.0; // Ensure growth does not exceed 100
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'waterLevel': waterLevel,
        'fertilizerLevel': fertilizerLevel,
        'sunlightLevel': sunlightLevel,
        'growth': growth,
        'lottieFile': lottieFile,
        'lastWatered': lastWatered.toIso8601String(),
        'lastFertilized': lastFertilized.toIso8601String(),
        'waterRequirement': waterRequirement,
        'sunlightRequirement': sunlightRequirement,
        'fertilizerRequirement': fertilizerRequirement,
      };

  static Plant fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] ?? '', // Provide a default value if null
      name: json['name'] ?? 'Unknown Plant', // Default name
      waterLevel: json['waterLevel']?.toDouble() ??
          0.0, // Convert to double with default
      fertilizerLevel: json['fertilizerLevel']?.toDouble() ?? 0.0,
      sunlightLevel: json['sunlightLevel']?.toDouble() ?? 0.0,
      growth: json['growth']?.toDouble() ?? 0.0,
      lottieFile: json['lottieFile'] ?? '', // Provide a default value if null
      lastWatered:
          DateTime.tryParse(json['lastWatered'] ?? '') ?? DateTime.now(),
      lastFertilized:
          DateTime.tryParse(json['lastFertilized'] ?? '') ?? DateTime.now(),
      waterRequirement: json['waterRequirement']?.toDouble() ?? 0.0,
      sunlightRequirement: json['sunlightRequirement']?.toDouble() ?? 0.0,
      fertilizerRequirement: json['fertilizerRequirement']?.toDouble() ?? 0.0,
    );
  }
}
