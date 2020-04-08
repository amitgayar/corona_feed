//title widget for listTile
import 'package:flutter/material.dart';
import 'dart:math';

///title widget for listTile in Feeds
title(title) {
  return Padding(
    padding: const EdgeInsets.only(top:20.0),
    child: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w500),
      maxLines:2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

///subtitle widget for 2 items
threeItemSubtitle(data1,data2,data3) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          (data1.isNotEmpty) ? data1 : "Tap to Read" ,
          style: TextStyle(
              fontWeight: FontWeight.normal),
          maxLines: 2,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Text(
              data2 ,
              style: TextStyle(
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Text(
              data3 ,
              style: TextStyle(
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),
          )
        ],
      )
    ],
  );
}

///subtitle widget for 2 items
twoItemSubtitle(data1,data2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          (data1.isNotEmpty) ? data1 : "Tap to Read" ,
          style: TextStyle(
              fontWeight: FontWeight.normal),
          maxLines: 2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10),
        child: Text(
          data2 ,
          style: TextStyle(
              fontWeight: FontWeight.w300),
          maxLines: 1,
        ),
      )
    ],
  );
}

///subtitle widget for 1 items
oneItemSubtitle(data1) {
  return Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10),
        child: Text(
          data1 ,
          style: TextStyle(
              fontWeight: FontWeight.w300),
          maxLines: 1,
        ),
      );
}

Random rnd = new Random();

///thumbnail widget for listTile
thumbnail(imageUrl) {
  return (imageUrl != null) ?
      Image.network(
        imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
      ) :
  SizedBox(width: 2,);
}

///thumbnail widget for User specific listTile
userThumbnail(imageUrl) {
  return (imageUrl != null) ?
  Image.network(
    imageUrl,
    height: 50,
    width: 70,
    alignment: Alignment.center,
  )  :
  ClipOval(
      child: Image.asset("assets/photoNotAvailaible.png")
  );
}