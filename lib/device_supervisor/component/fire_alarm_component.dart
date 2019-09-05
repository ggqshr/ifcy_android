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
            title: "紧急火警消息",
            messageNum: messageNum,
            viewList: viewList,
            onTalCall: (context) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<CheckAlarmListBloc>(
                  builder: (context) =>
                      CheckAlarmListBloc(CheckAlarmRepositories())
                        ..dispatch(FetchCheckedAlarmData(true)),
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
