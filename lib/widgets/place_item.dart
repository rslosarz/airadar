import 'package:airadar/model/place.dart';
import 'package:airadar/screens/weather_screen.dart';
import 'package:airadar/utils/resource_manager.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  const PlaceItem({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showItemDetail(context, place),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Hero(
              tag: place.properties.hashCode,
              child: Image.asset(
                ResourceManager.getPlaceImageAsset(place),
                width: 64.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        place.properties.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            place.properties.placeType,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            place.properties.country,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showItemDetail(BuildContext context, Place place) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WeatherScreen(place)));
  }
}
