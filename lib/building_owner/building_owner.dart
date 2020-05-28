import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/building_owner/blocs/building_owner_blocs.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';
import 'package:ifcy/device_supervisor/component/device_supervisor_component.dart';
import 'package:ifcy/device_supervisor/pages/device_supvisor_pages.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/building_owner/pages/building_owner_pages.dart';
import 'package:ifcy/common/components/components.dart';

import 'repositories/building_owner_repositories.dart';

class BuildingOwner extends StatefulWidget {
//  String auth;

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
      ..add(OwnerPage(
          () => Scaffold.of(context).openDrawer(),
          () => setState(() {
                curIndex = 3;
              })))
      ..add(FaultPage(() => Scaffold.of(context).openDrawer()))
      ..add(EmployeePage())
      ..add(CheckedAlarmPage(
          (thisTask) => CheckResultComponent(
              (thisTask as FireCheckAlarmMessage).fireType == "TRULY_ALARM"
                  ? "真火警"
                  : "误报"),
          true))
      ..add(PersonPage(() => Scaffold.of(context).openDrawer()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OwnerMonitorRepositories>(
          create: (context) => OwnerMonitorRepositories(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<OwnerMonitorBloc>(
            create: (context) {
              OwnerMonitorRepositories repo =
                  RepositoryProvider.of<OwnerMonitorRepositories>(context);
              return OwnerMonitorBloc(repo)
                ..add(FetchOwnerMonitorDataEvent());
            },
          ),
          BlocProvider<DeviceMessageBloc>(
            create: (context) {
              DeviceMessageRepositories repo = DeviceMessageRepositories();
              return DeviceMessageBloc(repo)..add(FetchAllDevices());
            },
          ),
          BlocProvider<EmployeeListBloc>(
            create: (context) {
              return EmployeeListBloc(EmployeeRepositories())
                ..add(FetchEmployeeListDataEvent());
            },
          ),
          BlocProvider<CheckAlarmListBloc>(
            create: (context) => CheckAlarmListBloc(CheckAlarmRepositories())
              ..add(FetchCheckedAlarmData(true)),
          )
        ],
        child: Scaffold(
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
            onTap: (v) {
              setState(() {
                curIndex = v;
              });
            },
            currentIndex: curIndex,
          ),
          body: viewList[curIndex],
        ),
      ),
    );
  }
}
