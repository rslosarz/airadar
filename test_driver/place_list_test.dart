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

//      SerializableFinder userList = find.byValueKey('place-list');
//      await driver.scroll(userList, 0.0, -300.0, Duration(milliseconds: 500));

//      expect(await driver.getText(find.text('Poznan')), isNotEmpty);
//      expect(await driver.getText(find.text('Berlin')), isNotEmpty);

      await driver.tap(find.text(MockPlaceApiResponse.placeSuggestions.places[0].properties.name));
      await driver.waitUntilNoTransientCallbacks();

      expect(await driver.getText(find.text(MockPlaceApiResponse.placeSuggestions.places[0].properties.name)), isNotEmpty);
      expect(await driver.getText(find.text('Cloud Details')), isNotEmpty);
    });

//    test('measure', () async {
//      // Record the performance timeline of things that happen inside the closure
//      Timeline timeline = await driver.traceAction(() async {
//        // Find the scrollable user list
//        SerializableFinder userList = find.byValueKey('user-list');
//
//        // Scroll down 5 times
//        for (int i = 0; i < 5; i++) {
//          // Scroll 300 pixels down, for 300 millis
//          await driver.scroll(
//              userList, 0.0, -300.0, Duration(milliseconds: 300));
//
//          // Emulate a user's finger taking its time to go back to the original
//          // position before the next scroll
//          await Future<void>.delayed(Duration(milliseconds: 500));
//        }
//
//        // Scroll up 5 times
//        for (int i = 0; i < 5; i++) {
//        await driver.scroll(
//        userList, 0.0, 300.0, Duration(milliseconds: 300));
//        await Future<void>.delayed(Duration(milliseconds: 500));
//        }
//      });
//
//      // The `timeline` object contains all the performance data recorded during
//      // the scrolling session. It can be digested into a handful of useful
//      // aggregate numbers, such as "average frame build time".
//      TimelineSummary summary = TimelineSummary.summarize(timeline);
//
//      // The following line saves the timeline summary to a JSON file.
//      summary.writeSummaryToFile('scrolling_performance', pretty: true);
//
//      // The following line saves the raw timeline data as JSON.
//      summary.writeTimelineToFile('scrolling_performance', pretty: true);
//    });
  });
}
