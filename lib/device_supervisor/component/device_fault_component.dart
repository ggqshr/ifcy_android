part of "device_supervisor_compoent.dart";

class DeviceFaultComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Card(
            child: StoreConnector<AppState, DeviceFaultModel>(
              converter: (Store<AppState> store) {
                return DeviceFaultModel(
                  messageNum: store
                      .state.deviceSupervisorModel.deviceFaultMessages.length,
                  messages:
                      store.state.deviceSupervisorModel.deviceFaultMessages,
                );
              },
              builder: (BuildContext context, DeviceFaultModel vm) {
                List<Widget> viewList = <Widget>[];

                //若没有消息应该显示空白以及提示
                if (vm.messageNum == 0) {
                  viewList.add(ListTile(
                    title: Text("当前无消息"),
                  ));
                } else {
                  viewList = vm.messages.map<Widget>((DeviceFaultMessage meg) {
                    return DeviceFaultTile(meg);
                  }).toList();
                }

                return ExpansionCard(
                  title: "今日设备故障",
                  messageNum: vm.messageNum,
                  viewList: viewList,
                );
              },
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
}

class DeviceFaultTile extends StatelessWidget {
  final DeviceFaultMessage meg;

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
          title: Text(meg.title),
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
