import 'package:airadar/model/place.dart';

class PlaceSuggestionsState {
  final bool loading;
  final bool error;
  final PlaceSuggestions placeSuggestions;

  PlaceSuggestionsState(
      {this.loading = false, this.error = false, this.placeSuggestions});
}
