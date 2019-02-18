import 'package:airadar/blocks/weather_block.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/mock/mock_weather_api_response.dart';
import 'package:airadar/repo/mock_weather_service.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:airadar/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  group('WeatherScreen', () {
    WeatherRepository repo;
    final place = MockPlaceApiResponse.placeSuggestions.places[0];
    final forecast = MockWeatherApiResponse.weather1;

    setUpAll(() {
      repo = MockWeatherService();
      final injector = Injector.getInjector();
      injector.map<WeatherRepository>((i) => repo, isSingleton: true);
      injector.map<WeatherBlock>(
          (i) => new WeatherBlock(injector.get<WeatherRepository>()));
    });

    testWidgets('displays weather forecast and place details',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await prepareWidget(tester, WeatherScreen(place));
        //needs to be pumped manually, as Flutter test lib forces manual state organizing
        await tester.pump();

        expect(find.text(place.properties.name), findsOneWidget);
        expect(find.byType(Image), findsNWidgets(2));
        expect(find.text("${forecast.main.temp.toStringAsFixed(0)} \u00b0C"),
            findsOneWidget);
        expect(find.text("${forecast.main.pressure.toStringAsFixed(0)} hPa"),
            findsOneWidget);
        expect(find.text("${forecast.wind.speed.toStringAsFixed(2)} m/s"),
            findsOneWidget);
        expect(find.text("${forecast.wind.deg.toStringAsFixed(0)} \u00b0"),
            findsOneWidget);
      });
    });
  });
}

void prepareWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}
