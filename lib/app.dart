import 'package:airadar/blocs/place_bloc.dart';
import 'package:airadar/screens/place_picker_screen.dart';
import 'package:airadar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AiradarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airadar',
      theme: AiradarTheme.theme,
      home: PlacePickerScreen(Injector.getInjector().get<PlaceBloc>()),
    );
  }
}
