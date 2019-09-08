part of 'building_owner_component.dart';

class BuildingOwnerAppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuildingOwnerAppBarModel>(
      converter: (Store<AppState> store) {
        return BuildingOwnerAppBarModel(
          buildingList: store.state.buildingOwnerModel.buildingList,
          currentBuilding: store.state.buildingOwnerModel.currentBuilding,
          onChangeBuildCall: (v) {
            store.dispatch(onChangeOwnerBuildingThunkAction(v));
          },
        );
      },
      onInit: (store) {
        store.dispatch(initOwnerBuildList);
      },
      builder: (BuildContext context, BuildingOwnerAppBarModel vm) {
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

