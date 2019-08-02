part of "device_supervisor_component.dart";

class SupervisorListComponent extends StatelessWidget {

  List <Widget> viewList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return StoreConnector<AppState, List<SupervisorMessageModel>>(
            converter: (Store<AppState> store) {
              return store.state.deviceSupervisorModel.supervisorMessages;
            },
            builder: (BuildContext context, List<SupervisorMessageModel> vm) {
              if (vm.length > 0) {
                viewList = vm.map<Widget>((SupervisorMessageModel meg) {
                  return SupervisorMessageTile(meg);
                }).toList();
              } else {
                viewList.add(CupertinoActivityIndicator());
              }
            });
      },
      itemCount: viewList.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          indent: 75,
          color: Color(0xFFDDDDDD),
        );
      },
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
      child: Row(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.green,
            ),
            trailing: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text(meg.name),
//          subtitle: Text(meg.content),
            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("跳转${meg.id}"),
                )),
          ),
        ],
      ),
    );
  }
}
