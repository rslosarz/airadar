import 'dart:async';

import 'package:airadar/model/place.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBlock {
  PlaceRepository placeRepo;

  Sink<String> get query => _queryStream.sink;
  final _queryStream = PublishSubject<String>();

  Stream<PlaceSuggestions> placeSuggestions;

  PlaceBlock(this.placeRepo) {
    placeSuggestions = _queryStream.stream
        .distinct()
        .debounce(const Duration(milliseconds: 500))
        .switchMap(_search);
  }

  void dispose() {
    _queryStream.close();
  }

  Stream<PlaceSuggestions> _search(String query) async* {
    yield await placeRepo.getPlaceSuggestions(query);
  }
}
