import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_staff/pages/device_staff_pages.dart';
import 'package:ifcy/main_app/model/AppState.dart';

class DeviceStaff extends StatefulWidget {
  Function drawerCall;
  DeviceStaff(this.drawerCall);
  @override
  _DeviceStaffState createState() => _DeviceStaffState();
}

class _DeviceStaffState extends State<DeviceStaff> {
  List<Widget> viewList = [];
  int currentIndex = 0;
  List<Icon> iconList = [
    Icon(Icons.work),
    Icon(Icons.person_outline),
  ];
  List<String> iconTextList = [
    "工作",
    "我的",
  ];
  @override
  void initState() {
    super.initState();
    viewList..add(DeviceStaffWorkPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: iconList.map<BottomNavigationBarItem>((i) {
          int currentIndex = iconList.indexOf(i);
          int currentBadge = StoreProvider.of<AppState>(context)
              .state
              .deviceSupervisorModel
              .bottomBadgeNumList[currentIndex];
          return BottomNavigationBarItem(
            icon: Badge(
              child: i,
              badgeContent: Text(
                currentBadge.toString(),
                style: TextStyle(color: Colors.white),
              ),
              showBadge: currentBadge != 0,
            ),
            title: Text(
              iconTextList[currentIndex],
            ),
          );
        }).toList(),
        onTap: (v) {
          setState(() {
            currentIndex = v;
          });
        },
        currentIndex: currentIndex,
      ),
      body: viewList[currentIndex],
    );
  }
}
