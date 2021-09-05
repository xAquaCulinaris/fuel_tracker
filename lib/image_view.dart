import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/api/firebase_ml_api.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late String cropedPath;
  String recognisedText = "";

  FirebaseMLApi firebaseMLApi = FirebaseMLApi();

  Future<String> getFilePath(String uid) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$uid.jpg';

    return filePath;
  }

  Future<void> cropImage() async {
    var image = img.decodeImage(File(widget.imagePath).readAsBytesSync())!;

    var cropedImage = img.copyCrop(image, 1400, 200, 250, 1750);
    print(image.height);
    print(image.width);

    var uid = Uuid().v1();
    File(await getFilePath(uid)).writeAsBytesSync(img.encodeJpg(cropedImage));
    cropedPath = await getFilePath(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      //body: Image.file(File(imagePath)),
      body: Column(
        children: [
          FutureBuilder<void>(
            future: cropImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("image");
                return Image.file(File(cropedPath));
              } else {
                print("indicator");
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          TextButton(
            onPressed: () async {
              String text = await firebaseMLApi
                  .processImage(InputImage.fromFilePath(cropedPath));
              if (mounted)
                setState(() {
                  recognisedText = text; 
                });
            },
            child: Text(
              "Show text",
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(width: 2, color: Colors.grey)),
            ),
          ),
          Text(recognisedText),
        ],
      ),
    );
  }
}
