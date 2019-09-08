import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/building_owner/pages/building_owner_pages.dart';
import 'package:ifcy/common/components/components.dart';

class BuildingOwner extends StatefulWidget {
//  String auth;
  Function drawerCall;

  BuildingOwner();

  @override
  _BuildingOwnerState createState() => _BuildingOwnerState();
}

class _BuildingOwnerState extends State<BuildingOwner> {
  List<Widget> viewList = [];
  int curIndex = 0;
  List<Icon> iconList = [
    Icon(Icons.business),
    Icon(Icons.warning),
    Icon(Icons.add),
    Icon(Icons.notification_important),
    Icon(Icons.person),
  ];
  List<String> iconTextList = ["大厦", "故障", "人员", "火警", "我"];
  List<int> bottomBadgeNumList = [1, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    viewList
      ..add(OwnerPage(widget.drawerCall))
      ..add(FaultPage(widget.drawerCall))
      ..add(EmployeePage())
      ..add(FireWarningPage())
      ..add(PersonPage(widget.drawerCall));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: iconList.map<BottomNavigationBarItem>((i) {
          int curIndex = iconList.indexOf(i);
          int curBadge = bottomBadgeNumList[curIndex];
          return BottomNavigationBarItem(
            icon: Badge(
              child: i,
              badgeContent: Text(
                curBadge.toString(),
                style: TextStyle(color: Colors.white),
              ),
              showBadge: curBadge != 0,
            ),
            title: Text(iconTextList[curIndex]),
          );
        }).toList(),
        onTap:(v){
          setState(() {
            curIndex=v;
          });
        } ,
        currentIndex: curIndex,
      ),
      body: viewList[curIndex],
    );
  }
}
