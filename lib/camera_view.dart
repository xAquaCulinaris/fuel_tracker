import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/api/extract_text.dart';

import 'image_view.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraDescription? firstCamera;
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  void initCamera() async {
    print("start");
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera!,
      ResolutionPreset.max,
    );

    if (mounted)
      setState(() {
        _initializeControllerFuture = _controller.initialize();
        print("initalizeeeed");
      });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> passDataBack(imagePath) async {
    String textToSendBack = await TextExtractor.extractText(imagePath);
    Navigator.pop(context, textToSendBack);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      //Futurebuilder to wait for initalization
      body: new CustomPaint(
        foregroundPainter: new GuidelineBox(),
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            await _controller.setFlashMode(FlashMode.off);
            final image = await _controller.takePicture();
            passDataBack(image.path);

            // await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => DisplayPictureScreen(
            //       imagePath: image.path,
            //     ),
            //   ),
            // );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class GuidelineBox extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..strokeWidth = 3.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Offset(40, 250) & Size(300, 60), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
