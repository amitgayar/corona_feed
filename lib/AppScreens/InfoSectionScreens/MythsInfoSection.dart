import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';

class MythsInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: mythItemList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = mythItemList[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10, 0),
            child: ListTile(
              title: Text(item['myth'],
                style: TextStyle(fontWeight: FontWeight.w500)),
              leading: ClipRect(child: Image.asset(item['image']))
            ),
          );
        }
    );
  }
}
