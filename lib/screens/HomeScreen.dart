import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/screens/CameraScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        CupertinoButton.filled(
          child: Text('카메라 테스트'),
          onPressed: () async {
            var cameras = await availableCameras();
            Get.to(() => CameraScreen(), arguments: cameras);
          },
        )
      ],
    );
  }
}
