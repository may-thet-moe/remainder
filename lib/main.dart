import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remainder/firebase_options.dart';
import 'package:remainder/screens/home_screen.dart';
import 'package:remainder/screens/login_screen.dart';
import 'package:remainder/utils/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remainder App',
      debugShowCheckedModeBanner: false,
      home: APIs.auth.currentUser != null ? HomeScreen() : LoginScreen(),
    );
  }
}
