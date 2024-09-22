import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/plant_model.dart'; // Ensure you import your Plant model

class PlantWidget extends StatefulWidget {
  final Plant plant; // Accept plant as a parameter

  PlantWidget({required this.plant});

  @override
  _PlantWidgetState createState() => _PlantWidgetState();
}

class _PlantWidgetState extends State<PlantWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double growth =
        widget.plant.growth; // Use widget.plant to access the passed plant
    double animationProgress = growth / 100.0;

    // Update animation progress based on plant growth
    if (animationProgress != _animationController.value) {
      _animationController.animateTo(animationProgress,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }

    return Center(
      child: Lottie.asset(
        widget.plant.lottieFile,
        controller: _animationController,
        fit: BoxFit.cover,
        animate: true,
        repeat: false, // Don't repeat animation indefinitely
      ),
    );
  }
}
