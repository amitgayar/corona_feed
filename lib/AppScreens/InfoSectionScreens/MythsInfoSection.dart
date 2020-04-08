import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';

class MythsInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
            child: ListTile(
                title: Text(mythItemList[0]['myth'],
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: ClipRect(child: Image.asset(mythItemList[0]['image']))
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
            child: ListTile(
                title: Text(mythItemList[1]['myth'],
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: ClipRect(child: Image.asset(mythItemList[1]['image']))
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
            child: ListTile(
                title: Text(mythItemList[2]['myth'],
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: ClipRect(child: Image.asset(mythItemList[2]['image']))
            ),
          ),
          ExpansionTile(
            title: Text(""),
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: mythItemList.length - 3,
                  itemBuilder: (BuildContext context, int index) {
                    final item = mythItemList[index + 3];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,10, 0),
                      child: ListTile(
                          title: Text(item['myth'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: ClipRect(child: Image.asset(item['image']))
                      ),
                    );
                  }
              ),
            ],
          ),
        ],
      );
  }
}
