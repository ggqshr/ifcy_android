import 'package:ifcy/common/model/model.dart';

class InitDeviceSupervisorStateAction {
  int faultNum;
  int taskRate;
  List<Build> buildingList;
  Build currentBuilding;
  List<int> bottomBadgeNumList;
  List<FireAlarmMessage> fireMessage;
  List<DeviceFaultMessage> deviceFaultMessage;
  List<TaskInfoMessage> taskInfoMessage;

  InitDeviceSupervisorStateAction({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireMessage,
    this.deviceFaultMessage,
    this.taskInfoMessage,
  });

  InitDeviceSupervisorStateAction.init()
      : faultNum = 0,
        taskRate = 23,
        bottomBadgeNumList = [1, 0, 0, 0],
        fireMessage = [
//          FireAlarmMessage(id: "1", title: "你好", content: "火灾"),
//          FireAlarmMessage(id: "2", title: "你好1", content: "火灾1")
        ],
        deviceFaultMessage = [
          DeviceFaultMessage(id: "1", title: "故障", content: "故障"),
          DeviceFaultMessage(id: "2", title: "故障1", content: "故障1"),
        ],
        taskInfoMessage = [
          TaskInfoMessage(
              id: "1",
              title: "任务1",
              content: "任务",
              status: TaskStatus.completed),
          TaskInfoMessage(
              id: "2",
              title: "任务2",
              content: "任务2",
              status: TaskStatus.uncompleted),
        ];
}

class DeviceSupervisorOnChangeBuilding {
  Build building;

  DeviceSupervisorOnChangeBuilding(this.building);
}

class DeviceSupervisorInitBuildingList {
  ///建筑物列表
  List<Build> buildingList;

  ///当前建筑
  Build currentBuilding;

  DeviceSupervisorInitBuildingList({this.buildingList, this.currentBuilding});
}
