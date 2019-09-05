part of "device_supervisor_component.dart";

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
            title: "今日设备故障",
            messageNum: messageNum,
            viewList: viewList,
            onTalCall: (context) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<CheckAlarmListBloc>(
                  builder: (context) =>
                      CheckAlarmListBloc(CheckAlarmRepositories())
                        ..dispatch(FetchCheckedAlarmData(false)),
                  child: CheckedAlarmPage(
                    (thisTask) => CheckResultComponent(
                        (thisTask as DeviceCheckedAlarmMessage).faultType ==
                                "PROCESSED"
                            ? "已处理"
                            : "未处理"),
                    false
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
          onTap: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return BlocProvider<ConfirmMessageBloc>(
                builder: (context) => ConfirmMessageBloc(
                  meg,
                  ConfirmMessageRepositories(),
                )..dispatch(
                    StartToConfirm(),
                  ),
                child: ConfirmMessagePage(),
              );
            }));
            BlocProvider.of<MonitorBloc>(context)
                .dispatch(FetchMonitorDataEvent());
          },
        ),
        elevation: 10,
      ),
    );
  }
}
