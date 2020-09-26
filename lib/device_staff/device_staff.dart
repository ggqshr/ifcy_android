import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import 'package:ifcy/device_staff/pages/device_staff_pages.dart';
import 'package:ifcy/device_staff/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/badge_bloc/badge_bloc.dart';

class DeviceStaff extends StatefulWidget {
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
    viewList
      ..add(DeviceStaffWorkPage(() => Scaffold.of(context).openDrawer()))
      ..add(PersonPage(() => Scaffold.of(context).openDrawer()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DeviceStaffTaskListRepositories>(
          create: (context) => DeviceStaffTaskListRepositories(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BadgeBloc>(
            create: (context) => BadgeBloc([1, 1]),
          ),
          BlocProvider<DeviceStaffTaskListBloc>(
            create: (context) => DeviceStaffTaskListBloc(
                RepositoryProvider.of<DeviceStaffTaskListRepositories>(context))
              ..add(FetchAll()),
          ),
        ],
        child: Scaffold(
          bottomNavigationBar: BlocBuilder<BadgeBloc, List<int>>(
            builder: (context, state) {
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
            },
          ),
          body: viewList[currentIndex],
        ),
      ),
    );
  }
}
