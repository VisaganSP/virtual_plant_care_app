import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
import '../models/plant_model.dart';
import '../services/firebase_service.dart';

class PlantController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var onlinePlants = <Plant>[].obs;
  var plants = <Plant>[
    Plant(
      name: "Sahara Cactus",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/cactus_growth_one.json',
      waterRequirement: 20.0,
      sunlightRequirement: 80.0,
      fertilizerRequirement: 20.0,
    ),
    Plant(
      name: "Flower Cactus",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/cactus_growth_two.json',
      waterRequirement: 10.0,
      sunlightRequirement: 90.0,
      fertilizerRequirement: 10.0,
    ),
    Plant(
      name: "Lily Flower",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/flower_plant_growth.json',
      waterRequirement: 70.0,
      sunlightRequirement: 100.0,
      fertilizerRequirement: 30.0,
    ),
    Plant(
      name: "Rose Flower",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/flower_plant_growth2.json',
      waterRequirement: 50.0,
      sunlightRequirement: 80.0,
      fertilizerRequirement: 10.0,
    ),
    Plant(
      name: "Maize Plant",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/maize_plant_growth.json',
      waterRequirement: 10.0,
      sunlightRequirement: 50.0,
      fertilizerRequirement: 60.0,
    ),
    Plant(
      name: "Snake Plant",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/snake_plant_growth.json',
      waterRequirement: 10.0,
      sunlightRequirement: 10.0,
      fertilizerRequirement: 10.0,
    ),
    Plant(
      name: "Tomato Plant",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/tomato_plant_growth.json',
      waterRequirement: 20.0,
      sunlightRequirement: 90.0,
      fertilizerRequirement: 10.0,
    ),
    Plant(
      name: "Mango Tree",
      lastWatered: DateTime.now(),
      lastFertilized: DateTime.now(),
      lottieFile: 'assets/animations/tree_growth.json',
      waterRequirement: 50.0,
      sunlightRequirement: 90.0,
      fertilizerRequirement: 40.0,
    ),
  ].obs;

  var selectedPlant = Plant(
    name: "Cactus",
    lastWatered: DateTime.now(),
    lastFertilized: DateTime.now(),
    lottieFile: 'assets/animations/cactus_growth_two.json',
    waterRequirement: 20.0,
    sunlightRequirement: 80.0,
    fertilizerRequirement: 20.0,
  ).obs;

  var backgroundColor = Colors.white.obs;
  Timer? sunlightTimer;

  bool get canWater => selectedPlant.value.canWater();
  bool get canFertilize => selectedPlant.value.canFertilize();

  @override
  void onInit() {
    super.onInit();
    fetchPlants();
    updateSunlightBasedOnTime();
    scheduleDailyNotifications();
  }

  Future<void> fetchPlants() async {
    onlinePlants.value = await _firebaseService.fetchPlants();
    print(plants.first.name);
  }

  void selectPlant(Plant plant) {
    selectedPlant.value = plant;
    updateSunlightBasedOnTime();
  }

  void waterPlant(BuildContext context) {
    if (canWater) {
      selectedPlant.update((val) {
        val?.waterPlant();
        _firebaseService.updatePlant(selectedPlant.value); // Update in Firebase
      });
      // Show confetti and message for successful watering
      Confetti.launch(
        context,
        options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6),
      );
      Get.snackbar(
        "Watering Success!",
        "You have successfully watered ${selectedPlant.value.name}.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.black,
      );
    } else {
      Confetti.launch(
        context,
        options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6),
      );
      Get.snackbar(
        "Come Back Tomorrow!",
        "${selectedPlant.value.name} has enough water for today.",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.yellow[100],
        colorText: Colors.black,
      );
    }
  }

  void fertilizePlant(BuildContext context) {
    if (canFertilize) {
      selectedPlant.update((val) {
        val?.fertilizePlant();
        _firebaseService.updatePlant(selectedPlant.value); // Update in Firebase
      });
      // Show confetti and message for successful fertilization
      Confetti.launch(
        context,
        options: const ConfettiOptions(particleCount: 200, spread: 100, y: 0.6),
      );
      Get.snackbar(
        "Fertilization Success!",
        "You have successfully fertilized ${selectedPlant.value.name}.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.black,
      );
    } else {
      Confetti.launch(
        context,
        options: const ConfettiOptions(particleCount: 200, spread: 100, y: 0.6),
      );
      Get.snackbar(
        "Come Back Tomorrow!",
        "${selectedPlant.value.name} has enough fertilizer for today.",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.yellow[100],
        colorText: Colors.black,
      );
    }
  }

  void updateSunlightBasedOnTime() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      backgroundColor.value = Colors.yellow.shade100;
      selectedPlant.value.sunlightLevel = 0;
      startSunlightAnimation();
    } else if (hour >= 12 && hour < 18) {
      backgroundColor.value = Colors.orange.shade100;
      selectedPlant.value.sunlightLevel =
          selectedPlant.value.sunlightRequirement;
    } else if (hour >= 18 && hour < 21) {
      backgroundColor.value = Colors.deepOrange.shade100;
      selectedPlant.value.sunlightLevel =
          selectedPlant.value.sunlightRequirement / 2;
    } else {
      backgroundColor.value = Colors.black;
      selectedPlant.value.sunlightLevel = 0;
      sunlightTimer?.cancel();
    }
    update();
  }

  void startSunlightAnimation() {
    sunlightTimer?.cancel();
    sunlightTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (selectedPlant.value.sunlightLevel <
          selectedPlant.value.sunlightRequirement) {
        selectedPlant.value.sunlightLevel += 5;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> scheduleDailyNotifications() async {
    // Schedule Watering Reminder
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Plant Care Reminder',
      'Time to water your plants!',
      _nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_channel',
          'Watering Reminders',
          channelDescription: 'Reminders to water your plants',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    // Schedule Fertilizing Reminder
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Plant Care Reminder',
      'Time to fertilize your plants!',
      _nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fertilizer_channel',
          'Fertilizing Reminders',
          channelDescription:
              'Reminders to fertilize your plants', // Added the message here
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> sendImmediateNotification() async {
    await flutterLocalNotificationsPlugin.show(
      2, // Notification ID (must be unique)
      'Plant Care Reminder',
      'Time to water your plants!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          channelDescription: 'Reminders to water your plants',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      2, // Notification ID (must be unique)
      'Plant Care Reminder',
      'Time to fertilize your plants!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          channelDescription: 'Reminders to fertilize your plants',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  void onClose() {
    sunlightTimer?.cancel();
    super.onClose();
  }
}
