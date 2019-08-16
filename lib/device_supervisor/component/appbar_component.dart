part of "device_supervisor_compoent.dart";

class AppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MonitorPageAppBarModel>(
      converter: (Store<AppState> store) {
        return MonitorPageAppBarModel(
          buildingList: store.state.deviceSupervisorModel.buildingList,
          currentBuild: store.state.deviceSupervisorModel.currentBuilding,
          onChangeCall: (v) {
            store.dispatch(DeviceSuperVisoronChangeBuildingThunkAction(v));
          },
        );
      },
      onInit: (store) {
        store.dispatch(DeviceSuperVisorInitBuildList);
      },
      builder: (BuildContext context, MonitorPageAppBarModel vm) {
        return DropdownButton(
          items: vm.buildingList.map((i) {
            return DropdownMenuItem<Build>(
              value: i,
              child: Text(i.buildName),
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
