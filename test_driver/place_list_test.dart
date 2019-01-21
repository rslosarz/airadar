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

      expect(await driver.getText(find.text('Poznan')), isNotEmpty);
      expect(await driver.getText(find.text('Berlin')), isNotEmpty);

//      SerializableFinder userList = find.byValueKey('place-list');
//      await driver.scroll(userList, 0.0, -300.0, Duration(milliseconds: 500));

      expect(await driver.getText(find.text('Poznan')), isNotEmpty);
      expect(await driver.getText(find.text('Berlin')), isNotEmpty);

      await driver.tap(find.text('Poznan'));
      await driver.waitUntilNoTransientCallbacks();

      expect(await driver.getText(find.text('Poznan')), isNotEmpty);
      expect(await driver.getText(find.text('Cloud Details')), isNotEmpty);
    });
  });
}
