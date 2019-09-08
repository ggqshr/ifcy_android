import 'package:ifcy/common/model/model.dart';

class InitOwnerPageStateAction {
  int fireNum; //火警数
  int faultNum; //故障数
  int taskProgress; //巡检进度
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<ProcessedDeviceFaultMessage> processedDeviceFaultList; //已处理的故障申报消息
  List<PersonnelMessage> projectStaffList; //项目人员列表

  InitOwnerPageStateAction({
    this.fireNum,
    this.faultNum,
    this.taskProgress,
    this.fireAlarmMessages,
    this.processedDeviceFaultList,
    this.projectStaffList,
  });

  InitOwnerPageStateAction.init()
      : fireNum = 12,
        faultNum = 15,
        taskProgress = 50,
        processedDeviceFaultList = List.generate(10, (index) {
          return ProcessedDeviceFaultMessage.generate(index.toString());
        });

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
