///@author ggq
///@description: 维保工作人员你的appbar组件
///@date :2019/8/16 14:15
part of 'device_staff_components.dart';

class DeviceStaffAppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DeviceStaffAppBarModel>(
      converter: (Store<AppState> store) {
        return DeviceStaffAppBarModel(
          buildingList: store.state.deviceStaffModel.buildingList,
          currentBuilding: store.state.deviceStaffModel.currentBuilding,
          onChangeBuildCall: (v) {
            store.dispatch(onChangeBuildingThunkAction);
          },
        );
      },
      onInit: (store) {
        store.dispatch(initBuildList);
      },
      builder: (BuildContext context, DeviceStaffAppBarModel vm) {
        return DropdownButton(
          items: vm.buildingList.map((i) {
            return DropdownMenuItem<Build>(
              value: i,
              child: Text(i.buildName),
            );
          }).toList(),
          onChanged: (v) => vm.onChangeBuildCall(v),
          value: vm.currentBuilding,
        );
      },
      distinct: true,
    );
  }
}
