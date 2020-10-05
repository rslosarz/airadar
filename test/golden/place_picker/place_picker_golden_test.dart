import 'package:airadar/blocs/place_bloc.dart';
import 'package:airadar/repo/mock/mock_place_service.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/screens/place_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tools/helpers.dart';
import '../tools/screen_size_extension.dart';

void main() {
  group('Golden tests', () {
    PlaceRepository repo;
    PlaceBloc bloc;
    setUpAll(() async {
      await loadFonts();

      repo = MockPlaceService();
      bloc = PlaceBloc(repo);
    });

    testWidgets('place picker screen with no query',
        (WidgetTester tester) async {
      await tester.setScreenSize();
      await prepareWidget(tester, PlacePickerScreen(bloc));
      await expectLater(
        find.byType(PlacePickerScreen),
        matchesGoldenFile('goldens/place_picker_empty.png'),
      );
    });

    testWidgets('place picker with results', (WidgetTester tester) async {
      await tester.setScreenSize();
      await prepareWidget(tester, PlacePickerScreen(bloc));
      await tester.enterText(find.byType(TextField), "ASD");

      await tester.pumpAndSettle(Duration(milliseconds: 500));
      await expectLater(
        find.byType(PlacePickerScreen),
        matchesGoldenFile('goldens/place_picker_with_results.png'),
      );
    });
  });
}
