import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuel_tracker/api/firebase_ml_api.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextDetectorView extends StatefulWidget {
  TextDetectorView();

  @override
  _TextDetectorViewState createState() => _TextDetectorViewState();
}

class _TextDetectorViewState extends State<TextDetectorView> {
  File? image;
  FirebaseMLApi firebaseMLApi = FirebaseMLApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Detector"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            TextButton(
              child: Text("Select image"),
              onPressed: pickImage,
            ),
            TextButton(
                onPressed: () {
                  if (image != null)
                    firebaseMLApi.processImage(InputImage.fromFile(image!));
                  else
                    print("no image selected");
                },
                child: Text("Get text"))
          ],
        ),
      ),
    );
  }

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image!)
            : Icon(Icons.photo, size: 80, color: Colors.black),
      );

  Future<void> pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setImage(File(file!.path));
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }
}
