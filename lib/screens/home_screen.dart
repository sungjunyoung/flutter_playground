import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter_playground/screens/camera_screen.dart';
import 'package:flutter_playground/screens/travel_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: <Widget>[
        TextButton(
          child: Text('Camera Test'),
          onPressed: () async {
            var cameras = await availableCameras();
            Get.to(() => CameraScreen(), arguments: cameras);
          },
        ),
        TextButton(
          child: Text('TDD Clean Architecture'),
          onPressed: () async {
            Get.to(() => NumberTriviaPage());
          },
        ),
        TextButton(
          child: Text('Travel UI Application'),
          onPressed: () async {
            Get.to(() => TravelScreen());
          },
        ),
      ],
    );
  }
}
