import 'package:electrocart/Screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:electrocart/Widgets/curved_Navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurvedNavigator(),
      // home: RegistrationPage(),
    ),
  );
}
