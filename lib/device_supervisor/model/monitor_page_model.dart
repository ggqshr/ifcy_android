part of 'device_supervisor_model.dart';

class MonitorPageAppBarModel {
  Function onChangeCall;
  List<String> buildingList;
  String currentBuild;

  MonitorPageAppBarModel({
    this.onChangeCall,
    this.buildingList,
    this.currentBuild,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonitorPageAppBarModel &&
          runtimeType == other.runtimeType &&
          buildingList == other.buildingList &&
          currentBuild == other.currentBuild;

  @override
  int get hashCode => buildingList.hashCode ^ currentBuild.hashCode;
}
