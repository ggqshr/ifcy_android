part of "device_supervisor_component.dart";

class SupervisorListComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      var supervisorMessageList =
          store.state.deviceSupervisorModel.supervisorMessages;
      return ListView.separated(
        itemCount: supervisorMessageList.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
             leading:  Icon(
                 Icons.account_box,
                 color: Colors.green,),
            title:Text(supervisorMessageList[index].name.toString()),
            subtitle: Text("XX大厦物业主管${supervisorMessageList[index].name.toString()}"),
            trailing:Icon(Icons.check_circle_outline),
            onTap: null,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return new Divider(
            indent: 2.0,
            height: 2.0,
            color: Colors.green,
          );
        },
      );
    });
  }
}
