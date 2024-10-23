import 'package:flutter/material.dart';
import 'package:pet_care_app/view/start_screen1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StartScreen1(),
    );
  }
}
