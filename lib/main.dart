import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home_screen.dart';
import '../services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  runApp(const VirtualPlantCareApp());
}

class VirtualPlantCareApp extends StatelessWidget {
  const VirtualPlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Plant Care',
      home: HomeScreen(),
      themeMode: ThemeMode.system, // Dynamic Day/Night Cycle
    );
  }
}
