part of 'device_supervisor_compoent.dart';

class FireAlarmComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return StoreConnector<AppState, FireAlarmModel>(
            converter: (Store<AppState> store) {
              return FireAlarmModel(
                messageNum: store
                    .state.deviceSupervisorModel.fireAlarmMessages.length,
                messages: store.state.deviceSupervisorModel.fireAlarmMessages,
              );
            },
            builder: (BuildContext context, FireAlarmModel vm) {
              List<Widget> viewList = <Widget>[];

              //若没有消息应该显示空白以及提示
              if (vm.messageNum == 0) {
                viewList.add(ListTile(
                  title: Text("当前无消息"),
                ));
              } else {
                viewList = vm.messages.map<Widget>((FireAlarmMessage meg) {
                  return FireMessageTile(meg);
                }).toList();
              }

              return ExpansionCard(
                title: "紧急火警消息",
                messageNum: vm.messageNum,
                viewList: viewList,
              );
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
          title: Text(meg.content),
          subtitle: Text(meg.content),
          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("跳转${meg.id}"),
              )),
        ),
        elevation: 10,
      ),
    );
  }
}
