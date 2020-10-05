import 'dart:io';
import 'dart:typed_data';

import 'package:airadar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> loadFonts() async {
  if (Directory.current.path.endsWith('/test')) {
    Directory.current = Directory.current.parent;
  }

  final fontData = File('assets/font/OpenSans.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontLoader = FontLoader('OpenSans')..addFont(fontData);
  await fontLoader.load();
}

Future<void> prepareWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AiradarTheme.theme,
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}
