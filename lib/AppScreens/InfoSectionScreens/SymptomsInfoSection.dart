import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modular_login/constants/constants.dart';

class SymptomInfoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imageCard(infoImages[0]),
          imageCard(infoImages[1]),
          imageCard(infoImages[2]),
        ],
      )
    );
  }
}

imageCard(item) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          item['text'],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(item['img']),
      )
    ],
  );
}
