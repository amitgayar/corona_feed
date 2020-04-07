import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modular_login/constants/constants.dart';

class SymptomInfoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        items: infoImages.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    child: Image.asset(i,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,),
                ),
              );
            },
          );
        }).toList(),
        autoPlay: true,
        autoPlayInterval: new Duration(seconds: 8),
        enlargeCenterPage: true,
      ),
    );
  }
}
