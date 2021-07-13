import 'package:flutter/material.dart';
import 'package:flutter_playground/screens/home_screen.dart';
import 'package:get/get.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
