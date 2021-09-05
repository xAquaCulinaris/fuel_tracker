import 'package:flutter/material.dart';
import 'package:fuel_tracker/camera_view.dart';
import 'package:fuel_tracker/home_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Tracker',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: //TextDetectorView(),
          HomeScreen(),
    );
  }
}
