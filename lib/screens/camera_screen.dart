import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller =
      CameraController(Get.arguments[0], ResolutionPreset.max);

  @override
  void initState() {
    super.initState();
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera',
        ),
      ),
      body: MaterialApp(home: CameraPreview(controller)),
      floatingActionButton: FloatingActionButton(
        child: Text('Shoot'),
        onPressed: () async {
          final image = await controller.takePicture();
          print(image);
        },
      ),
    );
  }
}
