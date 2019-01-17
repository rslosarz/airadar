import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/screens/place_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AiradarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airadar',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.amber,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: PlacePickerScreen(Injector.getInjector().get<PlaceBlock>()),
    );
  }
}
