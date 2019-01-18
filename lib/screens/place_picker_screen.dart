import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/place_suggestions_state.dart';
import 'package:airadar/widgets/fetch_error_widget.dart';
import 'package:airadar/widgets/loading_widget.dart';
import 'package:airadar/widgets/place_item.dart';
import 'package:flutter/material.dart';

class PlacePickerScreen extends StatelessWidget {
  final PlaceBlock placeBlock;

  PlacePickerScreen(this.placeBlock);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Picker'),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchInput(),
          _buildPlaceSuggestionList(),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Place for place...',
        ),
        onChanged: placeBlock.query.add,
      ),
    );
  }

  Widget _buildPlaceSuggestionList() {
    return StreamBuilder<PlaceSuggestionsState>(
      initialData: PlaceSuggestionsState(),
      stream: placeBlock.placeSuggestions,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return Expanded(
          child: _buildStateWidget(context, state),
        );
      },
    );
  }

  Widget _buildStateWidget(BuildContext context, PlaceSuggestionsState state) {
    if (state.loading) {
      return LoadingWidget();
    } else if (state.error) {
      return FetchErrorWidget();
    } else if (state.placeSuggestions == null ||
        state.placeSuggestions.places.isEmpty) {
      return _emptyListWidget();
    } else {
      return _placeSuggestionsList(state.placeSuggestions.places);
    }
  }

  Widget _emptyListWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.inbox,
            color: Colors.greenAccent,
            size: 100.0,
          ),
          Text(
            'List is empty',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeSuggestionsList(List<Place> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _buildPlaceItem(context, items[index]),
    );
  }

  Widget _buildPlaceItem(BuildContext context, Place item) {
    return PlaceItem(place: item);
  }
}
