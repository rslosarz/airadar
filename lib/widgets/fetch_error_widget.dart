import 'package:flutter/material.dart';

class FetchErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: 100.0,
          ),
          Text(
            'Error',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
