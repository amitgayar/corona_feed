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
    // TODO: implement initState
    super.initState();
    showAll = false;
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
//            child: ListTile(
//                title: Text(mythItemList[0]['myth'],
//                    style: TextStyle(fontWeight: FontWeight.w500)),
//                leading: ClipRect(child: Image.asset(mythItemList[0]['image']))
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
//            child: ListTile(
//                title: Text(mythItemList[1]['myth'],
//                    style: TextStyle(fontWeight: FontWeight.w500)),
//                leading: ClipRect(child: Image.asset(mythItemList[1]['image']))
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
//            child: ListTile(
//                title: Text(mythItemList[2]['myth'],
//                    style: TextStyle(fontWeight: FontWeight.w500)),
//                leading: ClipRect(child: Image.asset(mythItemList[2]['image']))
//            ),
//          ),
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
          Center(
            child: ListTile(
              title: Text((showAll) ?  "Show Less" : "Show More",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500,color: baseColor)),
              trailing : (showAll) ?  Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
              onTap: () {
                if(showAll) showAll = false;
                else showAll = true;
                setState((){});
              },
            ),
          )
        ],
      );
  }
}