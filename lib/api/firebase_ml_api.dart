import 'package:google_ml_kit/google_ml_kit.dart';

class FirebaseMLApi {
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  bool _isBusy = false;

  Future<String> processImage(InputImage inputImage) async {
    print("button pressed");
    if (_isBusy) return "";
    _isBusy = true;
    final recognisedText = await textDetector.processImage(inputImage);

    // List<String> words = recognisedText.text.split(" ");
    // var filteredWords = words.where((element) => element.length > 4);
    // print(filteredWords);
    return recognisedText.text;
  }
}
