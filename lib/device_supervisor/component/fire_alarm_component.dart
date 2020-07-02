part of 'device_supervisor_component.dart';

class FireAlarmComponent extends StatelessWidget {
  final List<FireAlarmMessage> msgs;

  FireAlarmComponent(this.msgs);

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
            onTalCall: (context) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<CheckAlarmListBloc>(
                  create: (context) =>
                      CheckAlarmListBloc(CheckAlarmRepositories())
                        ..add(FetchCheckedAlarmData(true)),
                  child: CheckedAlarmPage(
                    (thisTask) => CheckResultComponent(
                        (thisTask as FireCheckAlarmMessage).fireType ==
                                "TRULY_ALARM"
                            ? "真火警"
                            : "误报"),
                    true
                  ),
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

class FireMessageTile extends StatelessWidget {
  final FireAlarmMessage meg;

  FireMessageTile(this.meg);

  @override
  Widget build(BuildContext context) {
    MonitorBloc bloc = context.bloc<MonitorBloc>();
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
          onTap: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return BlocProvider<ConfirmMessageBloc>(
                create: (context) => ConfirmMessageBloc(
                  meg,
                  ConfirmMessageRepositories(),
                )..add(
                    StartToConfirm(),
                  ),
                child: ConfirmMessagePage(),
              );
            }));
            BlocProvider.of<MonitorBloc>(context)
                .add(FetchMonitorDataEvent());
          },
          onLongPress: ()async{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("确认要屏蔽该设备的通知？"),
                content: Text("请选择屏蔽时间"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("三天"),
                    onPressed: () async {
                      bloc.add(UpdateMonitorDataEvent(
                          meg.deviceCode, BlockTimeType.threeday));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("一天"),
                    onPressed: () async {
                      bloc.add(UpdateMonitorDataEvent(
                          meg.deviceCode, BlockTimeType.oneday));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("半天"),
                    onPressed: () async {
                      bloc.add(UpdateMonitorDataEvent(
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
