import 'package:airadar/model/place.dart';
import 'package:airadar/utils/resource_manager.dart';
import 'package:test/test.dart';

void main() {
  group('Resource Manager', () {
    test('city icon', () {
      final place = Place(properties: Properties(placeType: 'city'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('city.png'));

      final place2 = Place(properties: Properties(placeType: 'town'));
      expect(ResourceManager.getPlaceImageAsset(place2), contains('city.png'));
    });

    test('village icon', () {
      final place = Place(properties: Properties(placeType: 'village'));
      expect(
          ResourceManager.getPlaceImageAsset(place), contains('village.png'));

      final place2 = Place(properties: Properties(placeType: 'suburb'));
      expect(
          ResourceManager.getPlaceImageAsset(place2), contains('village.png'));
    });

    test('region icon', () {
      final place = Place(properties: Properties(placeType: 'region'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('region.png'));

      final place2 = Place(properties: Properties(placeType: 'county'));
      expect(
          ResourceManager.getPlaceImageAsset(place2), contains('region.png'));
    });

    test('region icon', () {
      final place = Place(properties: Properties(placeType: 'living_street'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('road.png'));

      final place2 = Place(properties: Properties(placeType: 'service'));
      expect(ResourceManager.getPlaceImageAsset(place2), contains('road.png'));

      final place3 = Place(properties: Properties(placeType: 'residential'));
      expect(ResourceManager.getPlaceImageAsset(place3), contains('road.png'));
    });

    test('river icon', () {
      final place = Place(properties: Properties(placeType: 'river'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('river.png'));
    });

    test('peak icon', () {
      final place = Place(properties: Properties(placeType: 'peak'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('peak.png'));
    });

    test('default icon', () {
      final place = Place(properties: Properties(placeType: 'asdf'));
      expect(ResourceManager.getPlaceImageAsset(place), contains('home.png'));
    });
  });
}
