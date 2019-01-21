import 'dart:async';

import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/place_suggestions_state.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockPlaceService extends Mock implements PlaceRepository {}

void main() {
  group('Place Block', () {
    PlaceBlock block;
    MockPlaceService api;

    setUp(() {
      api = MockPlaceService();
      block = PlaceBlock(api);
    });

    tearDown(() {
      api = null;
      block = null;
    });

    test('emits loading state then valid suggestion state', () {
      final suggestions =
          PlaceSuggestions(places: [Place(type: "A"), Place(type: "B")]);
      when(api.getPlaceSuggestions("ASD")).thenAnswer((_) async => suggestions);

      scheduleMicrotask(() {
        block.query.add("ASD");
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('switches query', () {
      final suggestions1 =
          PlaceSuggestions(places: [Place(type: "A"), Place(type: "B")]);

      final suggestions2 =
          PlaceSuggestions(places: [Place(type: "A"), Place(type: "B")]);
      when(api.getPlaceSuggestions("ASD"))
          .thenAnswer((_) async => suggestions1);
      when(api.getPlaceSuggestions("ZXC"))
          .thenAnswer((_) async => suggestions2);

      scheduleMicrotask(() {
        block.query.add("ASD");
        block.query.add("ZXC");
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions2)),
        ]),
      );
    });

    test('emits valid state with empty query', () {
      final suggestions = PlaceSuggestions(places: []);
      when(api.getPlaceSuggestions("")).thenAnswer((_) async => suggestions);

      scheduleMicrotask(() {
        block.query.add("");
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('emits valid state with empty list fetched from api', () {
      final suggestions = PlaceSuggestions(places: []);
      when(api.getPlaceSuggestions("ASD")).thenAnswer((_) async => suggestions);

      scheduleMicrotask(() {
        block.query.add("ASD");
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('emits error state when api throws an Exception', () {
      when(api.getPlaceSuggestions("ASD")).thenThrow(Exception());

      scheduleMicrotask(() {
        block.query.add("ASD");
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) => item.error),
        ]),
      );
    });

    test('stream emits done when block is disposed', () {
      scheduleMicrotask(() {
        block.dispose();
      });

      expect(
        block.placeSuggestions,
        emitsInOrder([
          emitsDone,
        ]),
      );
    });
  });
}

bool isValidSuggestionState(
    PlaceSuggestionsState state, PlaceSuggestions suggestions) {
  return state.placeSuggestions == suggestions &&
      !state.loading &&
      !state.error;
}
