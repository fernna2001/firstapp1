import 'package:flutter/material.dart';

class TrafficLight extends StatefulWidget {
  const TrafficLight({super.key});

  @override
  State<TrafficLight> createState() => _TrafficLightState();
}

class _TrafficLightState extends State<TrafficLight> {
  int _currentLight = 0;

  void _changeLight() {
    setState(() {
      _currentLight = (_currentLight + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Light Animation'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _currentLight == 0 ? 1.0 : 0.3,
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),

            AnimatedOpacity(
              opacity: _currentLight == 1 ? 1.0 : 0.3,
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),

            AnimatedOpacity(
              opacity: _currentLight == 2 ? 1.0 : 0.3,
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: _changeLight,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 244, 207, 223),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('เปลี่ยนไฟ', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
