import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  final String name;
  final Color colorBox;
  final Widget chileWitget;

  const GreetingWidget({
    super.key,
    this.name = 'World',
    this.colorBox = Colors.red,
    required this.chileWitget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Stateless Widget')),
      body: Center(
        child: chileWitget,
        // Container(
        //   color: colorBox,
        //   child: Text('Hello $name', style: TextStyle(fontSize: 22)),
        // ),
      ),
    );
  }
}
