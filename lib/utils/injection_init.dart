import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/blocks/weather_block.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/repo/place_service.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:airadar/repo/weather_service.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart' as http;

class InjectionInit {
  static void init() {
    final injector = Injector.getInjector();
    injector.map<http.Client>((i) => new http.Client());
    injector.map<WeatherRepository>((i) => new WeatherService(injector.get<http.Client>()),
        isSingleton: true);
    injector.map<WeatherBlock>(
        (i) => new WeatherBlock(injector.get<WeatherRepository>()));
    injector.map<PlaceRepository>((i) => new PlaceService(injector.get<http.Client>()),
        isSingleton: true);
    injector.map<PlaceBlock>(
        (i) => new PlaceBlock(injector.get<PlaceRepository>()));
  }

  static void dispose() {
    Injector.getInjector().dispose();
  }
}
