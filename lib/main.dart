import 'package:flutter/material.dart';
import 'package:text_adventure/scene_screen.dart';
import 'package:text_adventure/world.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SceneScreen(
        scene: World().getCurrentScene(),
      ),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        primaryColorDark: Colors.black,
        textTheme: TextTheme(
          body1: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
          ),
          title: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
