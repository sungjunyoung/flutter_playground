import 'package:flutter/material.dart';
import 'package:flutter_playground/screens/HomeScreen.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Startup Name Generator',
      darkTheme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Playground'),
          ),
          body: HomeScreen()),
    );
  }
}
