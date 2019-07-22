import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'model/device_supervisor_model.dart';
import 'device_supervisor_redux.dart';
import 'pages/device_supvisor_pages.dart';

class DeviceSupervisor extends StatefulWidget {
  String auth;

  DeviceSupervisor(this.auth);

  @override
  _DeviceSupervisorState createState() => _DeviceSupervisorState();
}

class _DeviceSupervisorState extends State<DeviceSupervisor> {
  List<Widget> viewList = [];
  int currentIndex = 0;
  List<Icon> iconList = [
    Icon(Icons.business),
    Icon(Icons.warning),
    Icon(Icons.format_list_bulleted),
    Icon(Icons.person_outline),
  ];
  List<String> iconTextList = [
    "大厦",
    "故障",
    "任务",
    "我的",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewList..add(MonitorPage());
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
      body: Container(
        child: Center(
          child: viewList[currentIndex],
        ),
      ),
    );
  }
}
