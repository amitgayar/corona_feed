import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';

class MythsInfoSection extends StatefulWidget {
  @override
  _MythsInfoSectionState createState() => _MythsInfoSectionState();
}

class _MythsInfoSectionState extends State<MythsInfoSection> {

  bool showAll ;

  @override
  void initState() {
    super.initState();
    showAll = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: (showAll) ? mythItemList.length : 3,
              itemBuilder: (BuildContext context, int index) {
                final item = mythItemList[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10, 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(item['myth'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: ClipRect(child: Image.asset(item['image']))
                      ),
                    Divider(),
                    ],
                  ),
                );
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text((showAll) ?  "Show Less" : "Show More",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,color: baseColor)),
              IconButton(
                  icon: (showAll) ?  Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
                  onPressed: () {
                    if(showAll) showAll = false;
                    else showAll = true;
                    setState((){});
                  })
            ],
          )
        ],
      );
  }
}