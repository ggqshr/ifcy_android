import 'package:ifcy/common/model/model.dart';

class InitDeviceStaffStateAction {
  List<int> badgeNumList; //底部导航栏微张数
  List<RegularInspectionTask> regularTasks; //日常巡查任务
  List<AdditionalInspectionTask> additionalTasks; //补充任务
  List<FaultInspectionTask> faultTasks; // 故障确认任务

  InitDeviceStaffStateAction(
      {this.badgeNumList,
      this.regularTasks,
      this.additionalTasks,
      this.faultTasks});

  InitDeviceStaffStateAction.init()
      : badgeNumList = [1, 2],
        regularTasks = List.generate(20, (index) {
          return RegularInspectionTask.generate(index.toString());
        }),
        additionalTasks = List.generate(20, (index) {
          return AdditionalInspectionTask.generate(index.toString());
        }),
        faultTasks = List.generate(20, (index) {
          return FaultInspectionTask.generate(index.toString());
        });
}

///维保工作人员更改建筑的action
class DeviceStaffChangeBuildAction {
  ///要更改的建筑
  Build changedBuilding;

  DeviceStaffChangeBuildAction({this.changedBuilding});
}

///初始化建筑物列表的action
class InitAppBarBuildingList {
  ///建筑物列表
  List<Build> buildingList;

  ///当前建筑物
  Build currentBuilding;

  InitAppBarBuildingList({this.buildingList, this.currentBuilding});
}
