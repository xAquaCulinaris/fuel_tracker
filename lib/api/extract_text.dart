import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

import 'firebase_ml_api.dart';

class TextExtractor {
  static extractText(String imagePath) async {
    String cropedImagePath = await _cropImage(imagePath);
    FirebaseMLApi firebaseMLApi = FirebaseMLApi();
    String text = await firebaseMLApi
        .processImage(InputImage.fromFilePath(cropedImagePath));
    return text;
  }

  static Future<String> _getFilePath(String uid) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$uid.jpg';

    return filePath;
  }

  static Future<String> _cropImage(String imagePath) async {
    var image = img.decodeImage(File(imagePath).readAsBytesSync())!;

    var cropedImage = img.copyCrop(image, 1400, 200, 250, 1750);
    print(image.height);
    print(image.width);

    var uid = Uuid().v1();
    File(await _getFilePath(uid)).writeAsBytesSync(img.encodeJpg(cropedImage));
    return await _getFilePath(uid);
  }
}
