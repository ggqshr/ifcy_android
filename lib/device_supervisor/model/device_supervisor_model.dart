import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/model/online_device_fault_sured_message.dart';
import 'package:ifcy/common/model/online_device_fault_unsrued_message.dart';

part 'monitor_page_model.dart';

part 'fire_alarm_model.dart';

part 'device_fault_model.dart';

part 'task_info_model.dart';

class DeviceSupervisorModel {
  int faultNum; //故障数
  int taskRate; //任务完成进度
  List<String> buildingList; //大厦列表
  String currentBuilding; //当前选中的大厦
  List<int> bottomBadgeNumList; // 底部导航栏的徽章数
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages;
  List<TaskInfoMessage> taskInfoMessages; // 任务执行情况消息
  List<SupervisorMessageModel> supervisorMessages; //主管信息
  List<DepartmentMessage> departmentMessages; //维保公司员工信息
  List<TaskCycleModel> taskCycleMessages; //任务类型信息
  List<TaskListViewModel> taskMessageViewList; //任务列表
  List<TaskExecuteModel> taskExecuteModel; //任务执行统计
  List<TaskDetailModel> taskList; //任务列表
  List<OfflineDeviceFaultMessage> offlineDeviceFaultList; //离线故障设备列表
  List<OnlineDeviceFaultSuredMessage>
      onlineDeviceFaultSuredList; //线上已确认故障设备消息列表
  List<OnlineDeviceFaultUnsuredMessage>
      onlineDeviceFaultUnSuredList; //线上待确认故障设备消息列表
  List<ProcessingDeviceFaultMessage> processingDeviceFaultList; //处理中的设备故障申报
  List<ProcessedDeviceFaultMessage> processedDeviceFaultList; //已处理的设备故障申报

  List<BuildingFloorMessage> buildingFloorList; //建筑以及楼层信息

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
    this.taskMessageViewList,
    this.taskExecuteModel,
    this.taskList,
    this.offlineDeviceFaultList,
    this.onlineDeviceFaultSuredList,
    this.onlineDeviceFaultUnSuredList,
    this.processedDeviceFaultList,
    this.processingDeviceFaultList,
    this.buildingFloorList,
  });

  DeviceSupervisorModel.init()
      : faultNum = 0,
        taskRate = 0,
        buildingList = ["tt", "tt2"],
        currentBuilding = "tt",
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
          DepartmentMessage(id: '01', title: '技术服务部', personnelList: [
            PersonnelMessage(id: '001', name: '员工1'),
            PersonnelMessage(id: '002', name: '员工2'),
            PersonnelMessage(id: '003', name: '员工3'),
          ]),
          DepartmentMessage(id: '02', title: '设计预算部', personnelList: [
            PersonnelMessage(id: '011', name: '员工1'),
            PersonnelMessage(id: '022', name: '员工2'),
            PersonnelMessage(id: '033', name: '员工3'),
          ]),
          DepartmentMessage(id: '03', title: '总经办', personnelList: [
            PersonnelMessage(id: '021', name: '员工1'),
            PersonnelMessage(id: '022', name: '员工2'),
            PersonnelMessage(id: '023', name: '员工3'),
          ]),
        ],
        taskMessageViewList = [
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述1',
                    type: '日常任务',
                    executor: 'xwz',
                    progress: 50,
                    cycle: '周检'),
                TaskDetailModel(
                    des: '任务描述2',
                    type: '日常任务',
                    executor: 'zxc',
                    progress: 60,
                    cycle: '周检'),
                TaskDetailModel(
                    des: '任务描述3',
                    type: '日常任务',
                    executor: 'xdd',
                    progress: 70,
                    cycle: '周检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述111',
                    type: '补充任务',
                    executor: 'xwz',
                    progress: 70,
                    cycle: '半月检'),
                TaskDetailModel(
                    des: '任务描述222',
                    type: '补充任务',
                    executor: 'zxc',
                    progress: 80,
                    cycle: '半月检'),
                TaskDetailModel(
                    des: '任务描述333',
                    type: '补充任务',
                    executor: 'xdd',
                    progress: 40,
                    cycle: '半月检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述11',
                    type: '日常任务',
                    executor: 'xwz',
                    progress: 50,
                    cycle: '月检'),
                TaskDetailModel(
                    des: '任务描述22',
                    type: '日常任务',
                    executor: 'zxc',
                    progress: 60,
                    cycle: '月检'),
                TaskDetailModel(
                    des: '任务描述33',
                    type: '日常任务',
                    executor: 'xdd',
                    progress: 70,
                    cycle: '月检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述1',
                    type: '日常任务',
                    executor: 'xwz',
                    progress: 50,
                    cycle: '季度检'),
                TaskDetailModel(
                    des: '任务描述2',
                    type: '日常任务',
                    executor: 'zxc',
                    progress: 60,
                    cycle: '季度检'),
                TaskDetailModel(
                    des: '任务描述3',
                    type: '日常任务',
                    executor: 'xdd',
                    progress: 70,
                    cycle: '季度检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述1',
                    type: '日常任务',
                    executor: 'xwz',
                    progress: 50,
                    cycle: '半年检'),
                TaskDetailModel(
                    des: '任务描述2',
                    type: '日常任务',
                    executor: 'zxc',
                    progress: 60,
                    cycle: '半年检'),
                TaskDetailModel(
                    des: '任务描述3',
                    type: '日常任务',
                    executor: 'xdd',
                    progress: 70,
                    cycle: '半年检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述1',
                    type: '日常任务',
                    executor: 'xwz',
                    progress: 50,
                    cycle: '年检'),
                TaskDetailModel(
                    des: '任务描述2',
                    type: '日常任务',
                    executor: 'zxc',
                    progress: 60,
                    cycle: '年检'),
                TaskDetailModel(
                    des: '任务描述3',
                    type: '日常任务',
                    executor: 'xdd',
                    progress: 70,
                    cycle: '年检'),
              ]),
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
