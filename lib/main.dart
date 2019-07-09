import 'package:airadar/app.dart';
import 'package:airadar/utils/injection_init.dart';
import 'package:flutter/material.dart';

void main() {
  InjectionInit.init();
  runApp(AiradarApp());
}
