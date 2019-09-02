import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_supervisor/repositories/monitor_repositories.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/common/utils/StoreCreater.dart';
import 'blocs/supervisor_blocs.dart';
import 'model/device_supervisor_model.dart';
import 'device_supervisor_redux.dart';
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
    Icon(Icons.warning),
    Icon(Icons.format_list_bulleted),
    Icon(Icons.person_outline),
  ];
  List<String> iconTextList = [
    "大厦",
    "故障",
    "工作",
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
            builder: (context) => MonitorRepositories(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MonitorBloc>(
              builder: (context) => MonitorBloc(
                  RepositoryProvider.of<MonitorRepositories>(context))
                ..dispatch(FetchMonitorDataEvent()),
            ),
            BlocProvider<PlanListBloc>(
              builder: (context) {
                PlanListRepositories repositories = PlanListRepositories();
                return PlanListBloc(repositories);
              },
            ),
            BlocProvider<TaskListBloc>(
              builder: (context) {
                TaskListRepositories repositories = TaskListRepositories();
                return TaskListBloc(repositories);
              },
            ),
            BlocProvider<BadgeBloc>(
              builder: (context) => BadgeBloc([1, 1, 2, 0],
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
