import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/widgets/place_item.dart';
import 'package:flutter/material.dart';

class PlacePickerScreen extends StatelessWidget {
  final PlaceBlock placeBlock;

  PlacePickerScreen(this.placeBlock);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaceSuggestions>(
      stream: placeBlock.placeSuggestions,
      builder: (context, snapshot) => getPlacePickerBody(context, snapshot),
    );
  }

  Widget getPlacePickerBody(
      BuildContext context, AsyncSnapshot<PlaceSuggestions> snapshot) {
    final items =
        snapshot.data != null ? snapshot.data.places : List<PlaceSuggestions>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Place Picker'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 24.0
              ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Place for place...',
              ),
              onChanged: placeBlock.query.add,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  _buildPlaceItem(context, items[index]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceItem(BuildContext context, Place item) {
    return PlaceItem(place: item);
  }
}
