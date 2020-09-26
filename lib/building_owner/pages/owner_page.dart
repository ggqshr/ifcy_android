part of "building_owner_pages.dart";

class OwnerPage extends StatelessWidget {
  final Function drawerCall;
  final Function fireSwitchCall;
  final ScrollController controller;

  OwnerPage(this.drawerCall, this.fireSwitchCall, this.controller);

  @override
  Widget build(BuildContext context) {
    OwnerMonitorBloc bloc = context.bloc<OwnerMonitorBloc>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: Text(
            (BlocProvider.of<AuthorizationBloc>(context).state as Authenticated)
                .currentBuild
                .buildName,
          ),
          onTap: () => controller.animateTo(0.0,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate),
        ),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              drawerCall();
            }),
      ),
      body: BlocBuilder<OwnerMonitorBloc, OwnerMonitorState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is LoadErrorOwnerMonitorDataState) {
            return LoadErrorPage(() => bloc.add(FetchOwnerMonitorDataEvent()));
          }
          if (state is LoadingOwnerMonitorDataState) {
            return LoadingPage();
          }
          if (state is LoadedOwnerMonitorDataState) {
            return RefreshIndicator(
              onRefresh: () async {
                bloc.add(FetchOwnerMonitorDataEvent());
              },
              child: CustomScrollView(
                controller: controller,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: DataStatisticsComponent(
                            faultNum: state.deviceFaultNum,
                            fireNum: state.fireNum,
                            taskProgress: state.taskCompleteRate,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  TrueFireComponent(state.trueFireNum),
                  FireAlarmComponent(state.fireAlarmMsg, fireSwitchCall),
                  DeviceFaultComponent(state.deviceFaultMsg),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

///数据统计模块
class DataStatisticsComponent extends StatelessWidget {
  final int faultNum;
  final int taskProgress;
  final int fireNum;

  DataStatisticsComponent({this.faultNum, this.taskProgress, this.fireNum});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: FaultNumComponent(faultNum.toString()),
        ),
        Flexible(
          flex: 2,
          child: GestureDetector(
            child: FireNumComponent(fireNum.toString()),
            //todo 跳转到任务
            onTap: () => Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("跳转任务"))),
          ),
        ),
        Flexible(
          flex: 2,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 120,
                  child: chart.PieChart(
                    [
                      chart.Series<List, int>(
                        id: 'hh',
                        domainFn: (List l, _1) => l[0],
                        measureFn: (List l, _1) => l[1],
                        data: [
                          [1, taskProgress],
                          [2, 100 - taskProgress],
                        ],
                        areaColorFn: (List l, int i) {
                          return chart.MaterialPalette.blue.shadeDefault;
                        },
                        colorFn: (List l, __) {
                          if (l[0] == 1) {
                            return chart.MaterialPalette.blue.shadeDefault;
                          } else {
                            return chart.MaterialPalette.green.shadeDefault;
                          }
                        },
                      ),
                    ],
                    animate: true,
                    defaultRenderer: chart.ArcRendererConfig(arcWidth: 10),
                  ),
                ),
                Text(
                  "${taskProgress.toString()}%",
                  textScaleFactor: 1.5,
                ),
                Positioned(
                  child: Text(
                    "巡查进度",
                  ),
                  bottom: 0,
                ),
              ],
              alignment: AlignmentDirectional.center,
            ),
            //todo 跳转到任务
            onTap: () => Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("跳转任务"))),
          ),
        ),
      ],
    );
  }
}

class FireAlarmComponent extends StatelessWidget {
  final List<FireAlarmMessage> msgs;
  final Function fireSwitchCall;

  FireAlarmComponent(this.msgs, this.fireSwitchCall);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          List<Widget> viewList = <Widget>[];
          int messageNum = msgs.length;
          //若没有消息应该显示空白以及提示
          if (messageNum == 0) {
            viewList.add(ListTile(
              title: Text("当前无消息"),
            ));
          } else {
            viewList = msgs.map<Widget>((FireAlarmMessage meg) {
              return FireMessageTile(meg);
            }).toList();
          }

          return ExpansionCard(
            title: "待处理火警预警",
            messageNum: messageNum,
            viewList: viewList,
            onTalCall: (context) => fireSwitchCall(),
          );
        },
        childCount: 1,
      ),
    );
  }
}

class FireMessageTile extends StatelessWidget {
  final FireAlarmMessage meg;

  FireMessageTile(this.meg);

  @override
  Widget build(BuildContext context) {
    OwnerMonitorBloc bloc = context.bloc<OwnerMonitorBloc>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: ListTile(
          leading: Icon(
            FontAwesomeIcons.fireAlt,
            color: Colors.red,
          ),
          trailing: Icon(
            Icons.chevron_right,
          ),
          title: Text(meg.deviceName),
          subtitle: Text("设备在${meg.sendTime.toString().substring(0, 10)}发出警报\n"
              "地点在${meg.floorName}的${meg.floorAreaName}"),
          onLongPress: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("确认要屏蔽该设备的通知？"),
                content: Text("请选择屏蔽时间"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("三天"),
                    onPressed: () async {
                      bloc.add(UpdateOwnerMonitorDataEvent(
                          meg.deviceCode, BlockTimeType.threeday));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("一天"),
                    onPressed: () async {
                      bloc.add(UpdateOwnerMonitorDataEvent(
                          meg.deviceCode, BlockTimeType.oneday));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("半天"),
                    onPressed: () async {
                      bloc.add(UpdateOwnerMonitorDataEvent(
                          meg.deviceCode, BlockTimeType.half));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        elevation: 10,
      ),
    );
  }
}

///设备故障模块
class DeviceFaultComponent extends StatelessWidget {
  final List<DeviceFaultAlarmMessage> msgs;

  DeviceFaultComponent(this.msgs);

  @override
  Widget build(BuildContext context) {
    int messageNum = msgs.length;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          List<Widget> viewList = <Widget>[];

          //若没有消息应该显示空白以及提示
          if (messageNum == 0) {
            viewList.add(ListTile(
              title: Text("当前无消息"),
            ));
          } else {
            viewList = msgs.map<Widget>((DeviceFaultAlarmMessage meg) {
              return DeviceFaultTile(meg);
            }).toList();
          }

          return ExpansionCard(
            title: "待处理设备故障",
            messageNum: messageNum,
            viewList: viewList,
            onTalCall: (context) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<CheckAlarmListBloc>(
                  create: (context) =>
                      CheckAlarmListBloc(CheckAlarmRepositories())
                        ..add(FetchCheckedAlarmData(false)),
                  child: CheckedAlarmPage(
                      (thisTask) => CheckResultComponent(
                          (thisTask as DeviceCheckedAlarmMessage).faultType ==
                                  "PROCESSED"
                              ? "已处理"
                              : "未处理"),
                      false,
                      (isfire) => RefreshCheckAlarmData(isfire),
                      (isfire) => FetchCheckedAlarmData(isfire)),
                );
              }));
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}

class DeviceFaultTile extends StatelessWidget {
  final DeviceFaultAlarmMessage meg;

  DeviceFaultTile(this.meg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: ListTile(
          leading: Icon(
            FontAwesomeIcons.solidBell,
            color: Colors.yellow.shade700,
          ),
          trailing: Icon(
            Icons.chevron_right,
          ),
          title: Text(meg.deviceName),
          subtitle:
              Text("设备在${meg.sendTime.toString().substring(0, 10)}发出故障警报\n"
                  "地点在${meg.floorName}的${meg.floorAreaName}"),
        ),
        elevation: 10,
      ),
    );
  }
}
