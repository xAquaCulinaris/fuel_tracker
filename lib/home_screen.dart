import 'package:flutter/material.dart';
import 'package:fuel_tracker/new_track_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Tracker"),
        centerTitle: true,
      ),
      body: Text("Display here old data"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: newTrackPressed,
      ),
    );
  }

  void newTrackPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewTrackView()),
    );
  }
}
