class Plant {
  String name;
  double waterLevel;
  double sunlightLevel;
  double growth;
  DateTime lastWatered;
  DateTime lastFertilized;

  Plant({
    required this.name,
    this.waterLevel = 100.0,
    this.sunlightLevel = 100.0,
    this.growth = 0.0,
    required this.lastWatered,
    required this.lastFertilized,
  });

  void waterPlant() {
    waterLevel = 100.0;
  }

  void fertilizePlant() {
    growth += 10.0;
  }
}
