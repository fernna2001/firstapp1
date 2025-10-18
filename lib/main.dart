import 'package:flutter/material.dart';
import 'package:firstapp1/page/traffic_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrafficLight(),
      debugShowCheckedModeBanner: false,
    );
  }
}
