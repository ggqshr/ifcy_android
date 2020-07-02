import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_supervisor/blocs/device_message_bloc/bloc.dart';
import 'package:ifcy/device_supervisor/repositories/monitor_repositories.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/common/utils/StoreCreater.dart';
import 'blocs/supervisor_blocs.dart';
import 'model/device_supervisor_model.dart';
import 'pages/device_supvisor_pages.dart';
import 'package:ifcy/common/components/components.dart';

class DeviceSupervisor extends StatefulWidget {
  DeviceSupervisor();

  @override
  _DeviceSupervisorState createState() => _DeviceSupervisorState();
}

class _DeviceSupervisorState extends State<DeviceSupervisor> {
  List<Widget> viewList = [];
  int currentIndex = 0;
  List<Icon> iconList = [
    Icon(Icons.business),
    Icon(Icons.devices),
    Icon(Icons.format_list_bulleted),
    Icon(Icons.person_outline),
  ];
  List<String> iconTextList = [
    "大厦",
    "设备",
    "巡检",
    "我的",
  ];

  @override
  void initState() {
    super.initState();
    viewList
      ..add(MonitorPage(() => Scaffold.of(context).openDrawer()))
      ..add(FaultPage(() => Scaffold.of(context).openDrawer()))
      ..add(WorkPage())
      ..add(PersonPage(() => Scaffold.of(context).openDrawer()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<MonitorRepositories>(
            create: (context) => MonitorRepositories(),
          ),
          RepositoryProvider<PlanListRepositories>(
            create: (context) => PlanListRepositories(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MonitorBloc>(
              create: (context) => MonitorBloc(
                  context.repository<UserLoginRepositories>(),
                  RepositoryProvider.of<MonitorRepositories>(context))
                ..add(FetchMonitorDataEvent()),
            ),
            BlocProvider<PlanListBloc>(
              create: (context) {
                PlanListRepositories repositories =
                    RepositoryProvider.of<PlanListRepositories>(context);
                return PlanListBloc(repositories);
              },
            ),
            BlocProvider<TaskListBloc>(
              create: (context) {
                TaskListRepositories repositories = TaskListRepositories();
                return TaskListBloc(repositories);
              },
            ),
            BlocProvider<DeviceMessageBloc>(
              create: (context) {
                DeviceMessageRepositories repo = DeviceMessageRepositories();
                return DeviceMessageBloc(repo)..add(FetchAllDevices());
              },
            ),
            BlocProvider<BadgeBloc>(
              create: (context) => BadgeBloc([1, 1, 2, 0],
                  monitorBloc: BlocProvider.of<MonitorBloc>(context)),
            ),
          ],
          child: Scaffold(
            bottomNavigationBar:
                BlocBuilder<BadgeBloc, List<int>>(builder: (context, state) {
              return BottomNavigationBar(
                elevation: 10,
                type: BottomNavigationBarType.fixed,
                items: iconList.map<BottomNavigationBarItem>((i) {
                  int currentIndex = iconList.indexOf(i);
                  int currentBadge = state[currentIndex];
                  return BottomNavigationBarItem(
                    icon: i,
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
              );
            }),
            body: viewList[currentIndex],
          ),
        ));
  }
}
