import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';

class SymptomInfoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imageCard(infoImages[0],Colors.red),
          imageCard(infoImages[1],Color.fromRGBO(249, 130, 16, 1)),
          imageCard(infoImages[2],Color.fromRGBO(134, 163, 92, 1)),
        ],
      )
    );
  }
}

imageCard(item,color) {
  return Column(
    children: <Widget>[
      (item['text'].isNotEmpty) ?
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          item['text'],
          style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: color
          ),
        ),
      ) : Container(),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(item['img']),
      )
    ],
  );
}
