//title widget for listTile
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'dart:math';

///title widget for listTile in Feeds
title(title) {
  return Padding(
    padding: const EdgeInsets.only(left: 5 ,top: 7,bottom : 5.0),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500),
      maxLines:2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

///subtitle widget for listTile in Feeds
subtitle(subTitle,source) {
  String sub = subTitle;
  return Padding(
    padding: const EdgeInsets.only(left: 5,right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          (sub.isNotEmpty) ? subTitle : "Tap to Read" ,
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.normal),
          maxLines: 2,
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              source ,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),
          ],
        )
      ],
    ),
  );
}

///subtitle widget for listTile in UserFeeds
userSubtitle(subTitle,source,datePosted) {
  return Padding(
    padding: const EdgeInsets.only(left: 5 ,right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          subTitle,
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.normal),
          maxLines: 2,
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Posted By:" + source ,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),
            Text(
              " On:" + datePosted ,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),

          ],
        )
      ],
    ),
  );
}

Random rnd = new Random();

///thumbnail widget for listTile
thumbnail(imageUrl) {
  return Padding(
    padding: const EdgeInsets.only(right : 10.0),
    child: (imageUrl != null) ?
    CachedNetworkImage(
      placeholder: (context, url) => Image.asset(noImageAvailable),
      imageUrl: imageUrl,
      height: 50,
      width: 70,
      alignment: Alignment.center,
    ) :
    Container(
        child: Image.asset(coronaImgList[rnd.nextInt(3)])),
  );
}

///thumbnail widget for User specific listTile
userThumbnail(imageUrl) {
  return Padding(
    padding: const EdgeInsets.only(right : 5.0),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child:
      (imageUrl != null) ? CachedNetworkImage(
        placeholder: (context, url) => Image.asset("/assets/no_image_availaible_.jpg"),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
      ) :
      Image.asset("assets/photoNotAvailaible.png"),
    ),
  );
}