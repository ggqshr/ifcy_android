import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/building_owner/blocs/building_owner_blocs.dart';
import 'package:ifcy/building_owner/repositories/building_owner_repositories.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:ifcy/property_manager/pages/property_manager_pages.dart';

class PropertyWorker extends StatefulWidget {
  @override
  _PropertyWorkerState createState() => _PropertyWorkerState();
}

class _PropertyWorkerState extends State<PropertyWorker> {
  List<Widget> viewList = [];
  int currentIndex = 0;
  List<Icon> iconList = [
    Icon(Icons.business),
    Icon(Icons.person_outline),
  ];
  List<String> iconTextList = [
    "大厦",
    "我的",
  ];
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    viewList
      ..add(MonitorPage(() => Scaffold.of(context).openDrawer(), controller))
      ..add(PersonPage(() => Scaffold.of(context).openDrawer()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<MonitorRepositories>(
            create: (context) => MonitorRepositories(),
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
                PlanListRepositories repositories = PlanListRepositories();
                return PlanListBloc(repositories);
              },
            ),
            BlocProvider<TaskListBloc>(
              create: (context) {
                TaskListRepositories repositories = TaskListRepositories();
                return TaskListBloc(repositories);
              },
            ),
            BlocProvider<DeclareMessageBloc>(
              create: (context) {
                return DeclareMessageBloc(ReportDeviceRepositories())
                  ..add(FetchDeclareMessage());
              },
            ),
            BlocProvider<EmployeeListBloc>(
              create: (context) {
                return EmployeeListBloc(EmployeeRepositories())
                  ..add(FetchEmployeeListDataEvent());
              },
            ),
            BlocProvider<DeviceMessageBloc>(
              create: (context) {
                DeviceMessageRepositories repo = DeviceMessageRepositories();
                return DeviceMessageBloc(repo)..add(FetchAllDevices());
              },
            ),
            BlocProvider<BadgeBloc>(
              create: (context) => BadgeBloc([1, 0],
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
              );
            }),
            body: viewList[currentIndex],
          ),
        ));
  }
}
