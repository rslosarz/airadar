import 'package:airadar/app.dart';
import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/blocks/weather_block.dart';
import 'package:airadar/repo/mock_place_service.dart';
import 'package:airadar/repo/mock_weather_service.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

void main() {
  initMockDi();

  enableFlutterDriverExtension();
  runApp(AiradarApp());
}

void initMockDi() {
  final injector = Injector.getInjector();
  injector.map<WeatherRepository>((i) => new MockWeatherService(),
      isSingleton: true);
  injector.map<WeatherBlock>(
      (i) => new WeatherBlock(injector.get<WeatherRepository>()));
  injector.map<PlaceRepository>((i) => new MockPlaceService(),
      isSingleton: true);
  injector
      .map<PlaceBlock>((i) => new PlaceBlock(injector.get<PlaceRepository>()));
}
