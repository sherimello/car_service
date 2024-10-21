import 'package:car_service/screens/home.dart';
import 'package:car_service/screens/splash_sign_in_register.dart';
import 'package:car_service/test.dart';
import 'package:car_service/widgets/home/service_creation_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDHQflLWrd7X9PRBnSi51rkWxKlI15ZPe4", appId: "1:606711742469:android:973bfa5e277dd1e7121c6c", messagingSenderId: "", projectId: "car-service-project-1f2ee"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      theme: ThemeData(
      colorSchemeSeed: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}