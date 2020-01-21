import 'dart:async';

import 'package:airadar/model/place_suggestions_state.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBloc {
  PlaceRepository placeRepo;

  Sink<String> get query => _queryStream.sink;
  final _queryStream = PublishSubject<String>();

  Stream<PlaceSuggestionsState> placeSuggestions;

  PlaceBloc(this.placeRepo) {
    placeSuggestions = _queryStream.stream
        .distinct()
        .debounce(const Duration(milliseconds: 500))
        .switchMap(_search);
  }

  void dispose() {
    _queryStream.close();
  }

  Stream<PlaceSuggestionsState> _search(String query) async* {
    yield PlaceSuggestionsState(loading: true);
    try {
      final placeSuggestions = await placeRepo.getPlaceSuggestions(query);
      yield PlaceSuggestionsState(placeSuggestions: placeSuggestions);
    } catch (e) {
      yield PlaceSuggestionsState(error: true);
    }
  }
}
