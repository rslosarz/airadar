import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Source:
/// https://medium.com/swlh/test-your-flutter-widgets-using-golden-files-b533ac0de469

extension SetScreenSize on WidgetTester {
  /// default values for Google Pixel
  Future<void> setScreenSize({
    double width = 411,
    double height = 732,
    double pixelDensity = 1,
  }) async {
    final size = Size(width, height);
    await this.binding.setSurfaceSize(size);
    this.binding.window.physicalSizeTestValue = size;
    this.binding.window.devicePixelRatioTestValue = pixelDensity;
  }
}
