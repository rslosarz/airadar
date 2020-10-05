import 'package:airadar/blocs/weather_bloc.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/mock/mock_weather_service.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:airadar/screens/weather_screen.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import '../tools/helpers.dart';
import '../tools/screen_size_extension.dart';

void main() {
  group('WeatherScreen', () {
    WeatherRepository repo;
    final place = MockPlaceApiResponse.placeSuggestions.places[0];

    setUpAll(() async {
      await loadFonts();

      repo = MockWeatherService();
      final injector = Injector.getInjector();
      injector.map<WeatherRepository>((i) => repo, isSingleton: true);
      injector.map<WeatherBloc>(
          (i) => new WeatherBloc(injector.get<WeatherRepository>()));
    });

    testWidgets('displays weather forecast and place details', (
      WidgetTester tester,
    ) async {
      await tester.setScreenSize();
      provideMockedNetworkImages(() async {
        await prepareWidget(tester, WeatherScreen(place));
        //needs to be pumped manually, as Flutter test lib forces manual state organizing
        await tester.pump();
        await expectLater(
          find.byType(WeatherScreen),
          matchesGoldenFile('goldens/weather_screen.png'),
        );
      });
    });
  });
}
