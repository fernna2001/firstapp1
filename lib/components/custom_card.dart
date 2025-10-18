import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final Color color;

  const CustomCard({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
