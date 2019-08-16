import 'package:ifcy/common/model/model.dart';

part 'monitor_page_model.dart';

part 'fire_alarm_model.dart';

part 'device_fault_model.dart';

part 'task_info_model.dart';

class DeviceSupervisorModel {
  int faultNum; //故障数
  int taskRate; //任务完成进度
  List<Build> buildingList; //大厦列表
  Build currentBuilding; //当前选中的大厦
  List<int> bottomBadgeNumList; // 底部导航栏的徽章数
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages;
  List<TaskInfoMessage> taskInfoMessages; // 任务执行情况消息

  DeviceSupervisorModel({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
    this.taskInfoMessages,
  });

  DeviceSupervisorModel.init()
      : faultNum = 0,
        taskRate = 0,
        buildingList = [Build(buildId: null, buildName: "所有建筑")],
        currentBuilding = Build(buildId: null, buildName: "所有建筑"),
        bottomBadgeNumList = [0, 0, 0, 0],
        fireAlarmMessages = [
          FireAlarmMessage(id: "1", title: "你好", content: "火灾"),
          FireAlarmMessage(id: "2", title: "你好1", content: "火灾1")
        ],
        deviceFaultMessages = [
          DeviceFaultMessage(id: "1", title: "故障", content: "故障"),
          DeviceFaultMessage(id: "2", title: "故障1", content: "故障1")
        ],
        taskInfoMessages = [
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceSupervisorModel &&
          runtimeType == other.runtimeType &&
          faultNum == other.faultNum &&
          taskRate == other.taskRate &&
          buildingList == other.buildingList &&
          currentBuilding == other.currentBuilding &&
          bottomBadgeNumList == other.bottomBadgeNumList;

  @override
  int get hashCode =>
      faultNum.hashCode ^
      taskRate.hashCode ^
      buildingList.hashCode ^
      currentBuilding.hashCode ^
      bottomBadgeNumList.hashCode;
}
