import 'package:ifcy/common/model/model.dart';

class InitOwnerPageStateAction {
  int fireNum; //火警数
  int faultNum; //故障数
  int taskProgress; //巡检进度
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages; //设备故障消息

  InitOwnerPageStateAction({
    this.fireNum,
    this.faultNum,
    this.taskProgress,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
  });

  InitOwnerPageStateAction.init()
      : fireNum = 12,
        faultNum = 15,
        taskProgress = 50,
        fireAlarmMessages = List.generate(5, (index) {
          return FireAlarmMessage.generate(index.toString());
        }),
        deviceFaultMessages = List.generate(5, (index) {
          return DeviceFaultMessage.generate(index.toString());
        });

  @override
  String toString() {
    return 'InitOwnerPageStateAction{faultNum: $faultNum, taskProgress: $taskProgress, fireAlarmMessages: $fireAlarmMessages, deviceFaultMessages: $deviceFaultMessages}';
  }
}

///业主切换建筑的action
class BuildingOwnerChangeBuildAction {
  ///要更改的建筑
  Build changedBuilding;

  BuildingOwnerChangeBuildAction({this.changedBuilding});
}

///初始化业主模块建筑列表的action
class InitOwnerPageAppBarBuildingList {
  ///建筑物列表
  List<Build> buildingList;

  ///当前建筑物
  Build currentBuilding;

  InitOwnerPageAppBarBuildingList({this.buildingList, this.currentBuilding});
}
