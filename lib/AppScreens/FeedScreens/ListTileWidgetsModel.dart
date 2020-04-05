//title widget for listTile
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'dart:math';

///title widget for listTile in Feeds
title(title) {
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.w500),
    maxLines:2,
    overflow: TextOverflow.ellipsis,
  );
}

///subtitle widget for listTile in Feeds
subtitle(subTitle,source) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          (subTitle.isNotEmpty) ? subTitle : "Tap to Read" ,
          style: TextStyle(
              fontWeight: FontWeight.normal),
          maxLines: 2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          source ,
          style: TextStyle(
              fontWeight: FontWeight.w300),
          maxLines: 1,
        ),
      )
    ],
  );
}

///subtitle widget for listTile in Feeds
feedSubtitle(source) {
  return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          source ,
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
  CachedNetworkImage(
    placeholder: (context, url) => Image.asset(noImageAvailable),
    imageUrl: imageUrl,
    height: 50,
    width: 70,
    alignment: Alignment.center,
  ) :
  SizedBox(width: 2,);
}

///thumbnail widget for User specific listTile
userThumbnail(imageUrl) {
  return (imageUrl != null) ?
  ClipOval(
    child: CachedNetworkImage(
      placeholder: (context, url) => Image.asset("/assets/no_image_availaible_.jpg"),
      imageUrl: imageUrl,
      height: 50,
      alignment: Alignment.center,
    ),
  ) :
  ClipOval(
      child: Image.asset("assets/photoNotAvailaible.png")
  );
}