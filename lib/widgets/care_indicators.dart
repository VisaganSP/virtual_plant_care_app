import 'package:flutter/material.dart';

import '../models/plant_model.dart';

class CareIndicators extends StatelessWidget {
  final Plant plant; // Accept the Plant parameter
  final Color backgroundColor; // Accept the background color

  CareIndicators(
      {required this.plant, required this.backgroundColor}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Get current plant's status
    double waterLevel = plant.waterLevel;
    double sunlightLevel = plant.sunlightLevel;
    double fertilizerLevel =
        plant.fertilizerLevel; // Use growth as fertilizer indicator

    // Determine text color based on background color
    Color textColor = (backgroundColor.computeLuminance() < 0.5)
        ? Colors.white // Light text for dark backgrounds
        : Colors.black; // Dark text for light backgrounds

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIndicator(
            Icons.opacity, "Water", waterLevel, Colors.blue, textColor),
        _buildIndicator(Icons.wb_sunny, "Sunlight", sunlightLevel,
            Colors.yellow, textColor),
        _buildIndicator(
            Icons.eco, "Fertilizer", fertilizerLevel, Colors.green, textColor),
      ],
    );
  }

  // Helper function to create the individual indicators
  Widget _buildIndicator(
      IconData icon, String label, double level, Color color, Color textColor) {
    return Column(
      children: [
        Icon(icon, size: 50, color: color),
        Text('$label: ${level.toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 16, color: textColor)),
      ],
    );
  }
}
