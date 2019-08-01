part of "device_supervisor_component.dart";

class SupervisorListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return StoreConnector<AppState, List<SupervisorMessageModel>>(
            converter: (Store<AppState> store) {
              return store.state.deviceSupervisorModel.supervisorMessages;
            },
            builder: (BuildContext context, List<SupervisorMessageModel> vm) {
              List<Widget> viewList = <Widget>[];

              //若没有消息应该显示空白以及提示
              if (vm.length == 0) {
                viewList.add(ListTile(
                  title: Text("当前无消息"),
                ));
              } else {
                viewList = vm.map<Widget>((SupervisorMessageModel meg) {
                  return SupervisorMessageTile(meg);
                }).toList();
              }

              return ExpansionCard(
                title: "紧急火警消息",
//                messageNum: vm.messageNum,
                viewList: viewList,
              );
            },
          );
        },
      ),
    );
  }
}

class SupervisorMessageTile extends StatelessWidget {
  final SupervisorMessageModel meg;

  SupervisorMessageTile(this.meg);

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
          title: Text(meg.name),
//          subtitle: Text(meg.content),
          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("跳转${meg.id}"),
              )),
        ),
        elevation: 10,
      ),
    );
  }
}
