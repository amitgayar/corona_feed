//title widget for listTile
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

title(title) {
  return Padding(
    padding: const EdgeInsets.only(top: 7,right: 8,bottom : 5.0),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500),
      maxLines:1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

//subtitle widget for listTile in Feeds
subtitle(subTitle,source) {
  String sub = subTitle;
  return Padding(
    padding: const EdgeInsets.only(right: 15),
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
        Text(
          source ,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300),
          maxLines: 1,
        )
      ],
    ),
  );
}

//subtitle widget for listTile in UserFeeds
userSubtitle(subTitle,source,datePosted) {
  return Padding(
    padding: const EdgeInsets.only(right: 15),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Posted On:" + datePosted ,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300),
              maxLines: 1,
            ),
            Text(
              "Posted By:" + source ,
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

//thumbnail widget for listTile
thumbnail(imageUrl) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: CircleAvatar(
      radius: 35,
      child:
      (imageUrl != null) ? CachedNetworkImage(
        placeholder: (context, url) => Image.asset("/assets/no_image_availaible_.jpg"),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ) :
      Image.asset("assets/defaultThumbnail.png"),
    ),
  );
}