import 'package:airadar/model/place.dart';

class ResourceManager {
  static String getPlaceImageAsset(Place place) {
    switch (place.properties.placeType) {
      case 'city':
      case 'town':
        return 'assets/icons/city.png';
      case 'village':
      case 'suburb':
      return 'assets/icons/village.png';
      case 'region':
      case 'county':
      return 'assets/icons/region.png';
      case 'living_street':
      case 'service':
      case 'residential':
      return 'assets/icons/road.png';
      case 'river':
        return 'assets/icons/river.png';
      case 'peak':
        return 'assets/icons/peak.png';
      default:
        return 'assets/icons/home.png';
    }
  }
}