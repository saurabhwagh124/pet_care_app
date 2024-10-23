import 'package:flutter/material.dart';
import 'package:pet_care_app/view/get_startscreen_1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:get_startscreen_1(),
    );
  }
}
