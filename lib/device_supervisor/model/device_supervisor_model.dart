import 'package:flutter/foundation.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monitor_page_model.dart';

part 'fire_alarm_model.dart';

part 'device_fault_model.dart';

part 'task_info_model.dart';

part 'add_task_bloc_model.dart';

part 'plan_list_page_model.dart';

part 'device_supervisor_model.g.dart';

class DeviceSupervisorModel {
  int faultNum; //故障数
  int taskRate; //任务完成进度
  List<Build> buildingList; //大厦列表
  Build currentBuilding; //当前选中的大厦
  List<int> bottomBadgeNumList; // 底部导航栏的徽章数
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages;
  List<TaskInfoMessage> taskInfoMessages; // 任务执行情况消息
  List<SupervisorMessageModel> supervisorMessages; //主管信息
  List<PersonnelMessage> departmentMessages; //维保公司员工信息
  PlanTaskListPageModel planPageModel; //计划页面的数据模型

  List<TaskCycleModel> taskCycleMessages; //任务类型信息
  List<TaskExecuteModel> taskExecuteList; //任务执行统计
  List<TaskDetailModel> taskDetailList; //任务详情列表

  List<OfflineDeviceFaultMessage> offlineDeviceFaultList; //离线故障设备列表
  List<OnlineDeviceFaultSuredMessage>
      onlineDeviceFaultSuredList; //线上已确认故障设备消息列表
  List<OnlineDeviceFaultUnsuredMessage>
      onlineDeviceFaultUnSuredList; //线上待确认故障设备消息列表

  List<ProcessingDeviceFaultMessage> processingDeviceFaultList; //处理中的设备故障申报
  List<ProcessedDeviceFaultMessage> processedDeviceFaultList; //已处理的设备故障申报

  List<BuildingFloorMessage> buildingFloorList; //建筑以及楼层信息

  List<InspectionSystem> inspectionSystems; //巡检系统数据

  DeviceSupervisorModel({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
    this.taskInfoMessages,
    this.supervisorMessages,
    this.departmentMessages,
    this.taskCycleMessages,
    this.taskExecuteList,
    this.taskDetailList,
    this.offlineDeviceFaultList,
    this.onlineDeviceFaultSuredList,
    this.onlineDeviceFaultUnSuredList,
    this.processedDeviceFaultList,
    this.processingDeviceFaultList,
    this.buildingFloorList,
    this.inspectionSystems,
    this.planPageModel,
  });

  DeviceSupervisorModel.init()
      : faultNum = 0,
        planPageModel = PlanTaskListPageModel.init(),
        taskRate = 0,
        buildingList = [Build(buildId: null, buildName: "所有建筑")],
        currentBuilding = Build(buildId: null, buildName: "所有建筑"),
        bottomBadgeNumList = [0, 0, 0, 0],
//        fireAlarmMessages = [
//          FireAlarmMessage(eventId: "1", deviceName: "你好", sendTime: "火灾"),
//          FireAlarmMessage(eventId: "2", deviceName: "你好1", sendTime: "火灾1")
//        ],
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
        ],
        supervisorMessages = [
          SupervisorMessageModel(
            name: '主管1',
          ),
          SupervisorMessageModel(
            name: '主管2',
          ),
          SupervisorMessageModel(
            name: '主管3',
          )
        ],
        departmentMessages = [
          PersonnelMessage(id: "1", name: '员工1'),
          PersonnelMessage(id: "2", name: '员工2'),
          PersonnelMessage(id: "3", name: '员工3'),
          PersonnelMessage(id: "1", name: '员工1'),
          PersonnelMessage(id: "2", name: '员工2'),
          PersonnelMessage(id: "3", name: '员工3'),
          PersonnelMessage(id: "1", name: '员工1'),
          PersonnelMessage(id: "2", name: '员工2'),
          PersonnelMessage(id: "3", name: '员工3'),
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

//线上设备故障视图模型
class OnlineDeviceFaultMessageViewModel {
  List<OnlineDeviceFaultSuredMessage> onlineDeviceFaultSuredMessage;
  List<OnlineDeviceFaultUnsuredMessage> onlineDeviceFaultUnSuredMessage;
  Function onRefreshCall;

  OnlineDeviceFaultMessageViewModel({
    this.onlineDeviceFaultSuredMessage,
    this.onlineDeviceFaultUnSuredMessage,
    this.onRefreshCall,
  });
}

//故障申报视图模型
class FaultDeclareMessageViewModel {
  List<ProcessedDeviceFaultMessage> processedDeviceFaultDeclareList;
  List<ProcessingDeviceFaultMessage> processingDeviceFaultDeclareList;
  Function onRefreshCall;

  FaultDeclareMessageViewModel({
    this.processedDeviceFaultDeclareList,
    this.processingDeviceFaultDeclareList,
    this.onRefreshCall,
  });
}

//新增工作视图模型
class TaskAddViewModel {
  List<BuildingFloorMessage> buildingFloorList;
  List<TaskCycleModel> taskCycleList;

  Function onRefreshCall;

  TaskAddViewModel({
    this.buildingFloorList,
    this.taskCycleList,
    this.onRefreshCall,
  });
}

///任务执行视图类
class TaskListViewModel {
  List<TaskCycleModel> taskCycleList; //任务执行周期
  List<TaskExecuteModel> taskExecuteList; //任务执行情况统图表
  List<TaskDetailModel> taskDetailList; //任务执行详细列表
  Function onRefreshCall;

  TaskListViewModel({
    this.taskCycleList,
    this.taskExecuteList,
    this.taskDetailList,
    this.onRefreshCall,
  });
}
