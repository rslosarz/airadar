import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/repo/place_service.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class InjectionInit {
  static void init() {
    final injector = Injector.getInjector();
    injector.map<PlaceRepository>((i) => new PlaceService(), isSingleton: true);
    injector.map<PlaceBlock>((i) => new PlaceBlock(injector.get<PlaceRepository>()));
  }

  static void dispose() {
    Injector.getInjector().dispose();
  }
}