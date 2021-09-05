import 'package:flutter/material.dart';

import 'camera_view.dart';

class NewTrackView extends StatefulWidget {
  const NewTrackView({Key? key}) : super(key: key);

  @override
  _NewTrackViewState createState() => _NewTrackViewState();
}

class _NewTrackViewState extends State<NewTrackView> {
  TextEditingController mileageController = TextEditingController();
  TextEditingController litersController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  milageButtonPressed() async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CameraView()),
    );
    setState(() {
      mileageController.text = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Refuel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mileageController,
                    decoration: InputDecoration(labelText: "Mileage"),
                  ),
                ),
                IconButton(
                    onPressed: milageButtonPressed,
                    icon: Icon(Icons.camera_alt))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: litersController,
                    decoration: InputDecoration(labelText: "Liters"),
                  ),
                ),
                IconButton(
                    onPressed: milageButtonPressed,
                    icon: Icon(Icons.camera_alt))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: "Price"),
                  ),
                ),
                IconButton(
                    onPressed: milageButtonPressed,
                    icon: Icon(Icons.camera_alt))
              ],
            ),
            TextButton(
              onPressed: () {
                print(mileageController.text);
                print(litersController.text);
                print(priceController.text);
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(width: 2, color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
