import 'dart:async';

import 'package:airadar/blocs/place_bloc.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/place_suggestions_state.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalMockPlaceService extends Mock implements PlaceRepository {}

void main() {
  group('Place Bloc', () {
    PlaceBloc bloc;
    LocalMockPlaceService api;

    setUp(() {
      api = LocalMockPlaceService();
      bloc = PlaceBloc(api);
    });

    test('emits loading state then valid suggestion state', () {
      PlaceSuggestions suggestions = MockPlaceApiResponse.placeSuggestions;
      setupPlaceSuggestionsMockResponse(api, "QUERY", suggestions);

      scheduleMicrotask(() {
        bloc.query.add("QUERY");
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('switches query', () {
      final suggestions1 = MockPlaceApiResponse.placeSuggestions;
      final suggestions2 =
          PlaceSuggestions(places: [Place(type: "C"), Place(type: "D")]);
      setupPlaceSuggestionsMockResponse(api, "QUERY", suggestions1);
      setupPlaceSuggestionsMockResponse(api, "QUERY2", suggestions2);

      scheduleMicrotask(() {
        bloc.query.add("QUERY");
        bloc.query.add("QUERY2");
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions2)),
        ]),
      );
    });

    test('emits valid state with empty query', () {
      final suggestions = PlaceSuggestions(places: []);
      setupPlaceSuggestionsMockResponse(api, "", suggestions);

      scheduleMicrotask(() {
        bloc.query.add("");
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('emits valid state with empty list fetched from api', () {
      final suggestions = PlaceSuggestions(places: []);
      setupPlaceSuggestionsMockResponse(api, "QUERY", suggestions);

      scheduleMicrotask(() {
        bloc.query.add("QUERY");
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) =>
              isValidSuggestionState(item, suggestions)),
        ]),
      );
    });

    test('emits error state when api throws an Exception', () {
      when(api.getPlaceSuggestions("QUERY")).thenThrow(Exception());

      scheduleMicrotask(() {
        bloc.query.add("QUERY");
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emits((PlaceSuggestionsState item) => item.loading),
          emits((PlaceSuggestionsState item) => item.error),
        ]),
      );
    });

    test('stream emits done when bloc is disposed', () {
      scheduleMicrotask(() {
        bloc.dispose();
      });

      expect(
        bloc.placeSuggestions,
        emitsInOrder([
          emitsDone,
        ]),
      );
    });
  });
}

void setupPlaceSuggestionsMockResponse(
    LocalMockPlaceService mockApi, String query, PlaceSuggestions suggestions) {
  when(mockApi.getPlaceSuggestions(query)).thenAnswer((_) async => suggestions);
}

bool isValidSuggestionState(
    PlaceSuggestionsState state, PlaceSuggestions suggestions) {
  return state.placeSuggestions == suggestions &&
      !state.loading &&
      !state.error;
}
