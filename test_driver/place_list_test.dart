import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Critical Path', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('type in name and open weather detail', () async {
      await driver.tap(find.byType('TextField'));
      await driver.enterText("ASD");
      await driver.waitUntilNoTransientCallbacks();

      expect(await driver.getText(find.text(MockPlaceApiResponse.placeSuggestions.places[0].properties.name)), isNotEmpty);
      expect(await driver.getText(find.text(MockPlaceApiResponse.placeSuggestions.places[1].properties.name)), isNotEmpty);
      expect(await driver.getText(find.text(MockPlaceApiResponse.placeSuggestions.places[2].properties.name)), isNotEmpty);

      await driver.tap(find.text(MockPlaceApiResponse.placeSuggestions.places[0].properties.name));
      await driver.waitUntilNoTransientCallbacks();

      expect(await driver.getText(find.text(MockPlaceApiResponse.placeSuggestions.places[0].properties.name)), isNotEmpty);
      expect(await driver.getText(find.text('Cloud Details')), isNotEmpty);
    });
  });
}
