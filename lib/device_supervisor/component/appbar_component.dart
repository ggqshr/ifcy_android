part of "device_supervisor_component.dart";

class AppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MonitorPageAppBarModel>(
      converter: (Store<AppState> store) {
        return MonitorPageAppBarModel(
          buildingList: store.state.deviceSupervisorModel.buildingList,
          currentBuild: store.state.deviceSupervisorModel.currentBuilding,
          onChangeCall: (v) {
            store.dispatch(OnChangeBuilding(v));
          },
        );
      },
      builder: (BuildContext context, MonitorPageAppBarModel vm) {
        return DropdownButton(
          items: vm.buildingList.map((i) {
            return DropdownMenuItem<String>(
              value: i,
              child: Text(i),
            );
          }).toList(),
          onChanged: (v) => vm.onChangeCall(v),
          value: vm.currentBuild,
        );
      },
      distinct: true,
    );
  }
}
