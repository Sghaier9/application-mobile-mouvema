import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:device_preview/device_preview.dart';
import 'src/app.dart';
import 'src/data/data_source/remote_data_source/firebase_options.dart';
import 'src/injector.dart';

void main() async {
  await globalInstances();

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  //Hive.registerAdapter(UserAdapter());
  //Hive.registerAdapter(LoadAdapter());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: true, // Active l'aperçu des appareils
      builder: (context) => MyApp(), // Ton application
    ),
  );
  // runApp(const MyApp());
}
