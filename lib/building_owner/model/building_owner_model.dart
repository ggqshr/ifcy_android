import 'package:ifcy/common/model/model.dart';

part 'building_owner_appbar_model.dart';



///@author lc
///@descriprion:业主的数据模块和视图模块
///@data

class BuildingOwnerModel {
  int fireNum; //火警数
  int faultNum; //故障数
  int taskProgress; //巡检进度
  List<Build> buildingList = [Build(buildId: null, buildName: "所有大厦")]; //大厦列表
  Build currentBuilding; //当前选中的大厦
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages; //设备故障消息

  BuildingOwnerModel({
    this.fireNum,
    this.faultNum,
    this.taskProgress,
    this.buildingList,
    this.currentBuilding,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
  });

  BuildingOwnerModel.init()
      : faultNum = 0,
        fireNum = 0,
        taskProgress = 10,
        buildingList = [Build(buildId: null, buildName: "所有大厦")],
        currentBuilding = Build(buildId: null, buildName: "所有大厦");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingOwnerModel &&
          runtimeType == other.runtimeType &&
          fireNum == other.fireNum &&
          faultNum == other.faultNum &&
          taskProgress == other.taskProgress &&
          buildingList == other.buildingList &&
          currentBuilding == other.currentBuilding;

  @override
  int get hashCode =>
      fireNum.hashCode ^
      faultNum.hashCode ^
      taskProgress.hashCode ^
      buildingList.hashCode ^
      currentBuilding.hashCode;
}

//业主首页视图模型
class BuildingOwnerMainViewModel {
  int fireNum;
  int faultNum;
  int taskProgress;
  List<FireAlarmMessage> fireAlarmMessageList;
  List<DeviceFaultMessage> deviceFaultMessageList;

  BuildingOwnerMainViewModel(
      {this.fireNum,
      this.faultNum,
      this.taskProgress,
      this.fireAlarmMessageList,
      this.deviceFaultMessageList});
}
