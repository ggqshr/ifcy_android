import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

class InitDeviceSupervisorStateAction {
  int faultNum;
  int taskRate;
  List<Build> buildingList;
  Build currentBuilding;
  List<int> bottomBadgeNumList;
  List<FireAlarmMessage> fireMessage;
  List<DeviceFaultMessage> deviceFaultMessage;
  List<TaskInfoMessage> taskInfoMessage;
  List<DepartmentMessage> departmentMessage;

  List<TaskCycleModel> taskCycleMessages; //任务周期类别信息
  List<TaskExecuteModel> taskExecuteList; //任务执行信息
  List<TaskDetailModel> taskDetailList; //任务列表信息

  List<OfflineDeviceFaultMessage> offlineDeviceFaultList; //离线设备故障消息列表
  List<OnlineDeviceFaultSuredMessage>
      onlineDeviceFaultSuredList; //线上已确认故障设备消息列表
  List<OnlineDeviceFaultUnsuredMessage>
      onlineDeviceFaultUnSuredList; //线上待确认故障设备消息列表

  List<SupervisorMessageModel> supervisorMessages; //主管信息列表

  List<ProcessingDeviceFaultMessage> processingDeviceFaultList; //处理中的设备故障申报
  List<ProcessedDeviceFaultMessage> processedDeviceFaultList; //已处理的设备故障申报

  List<BuildingFloorMessage> buildingFloorList; //建筑楼层信息

  InitDeviceSupervisorStateAction({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireMessage,
    this.deviceFaultMessage,
    this.taskInfoMessage,
    this.departmentMessage,
    this.taskCycleMessages,
    this.taskExecuteList,
    this.taskDetailList,
    this.offlineDeviceFaultList,
    this.onlineDeviceFaultSuredList,
    this.onlineDeviceFaultUnSuredList,
    this.supervisorMessages,
    this.processingDeviceFaultList,
    this.processedDeviceFaultList,
    this.buildingFloorList,
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
        ],
        taskCycleMessages = [
          TaskCycleModel(cycleId: '1', item: '周检'),
          TaskCycleModel(cycleId: '2', item: '日检'),
          TaskCycleModel(cycleId: '3', item: '月检'),
          TaskCycleModel(cycleId: '4', item: '季度检'),
          TaskCycleModel(cycleId: '5', item: '半年检'),
          TaskCycleModel(cycleId: '6', item: '年检'),
        ],
        taskExecuteList = [
          TaskExecuteModel(
              taskCycle: '周检',
              taskNum: 10,
              taskUnCompletedNum: 3,
              taskCompletedNum: 7),
          TaskExecuteModel(
              taskCycle: '半月检',
              taskNum: 20,
              taskUnCompletedNum: 3,
              taskCompletedNum: 17),
          TaskExecuteModel(
              taskCycle: '月检',
              taskNum: 10,
              taskUnCompletedNum: 3,
              taskCompletedNum: 7),
          TaskExecuteModel(
              taskCycle: '季度检',
              taskNum: 30,
              taskUnCompletedNum: 13,
              taskCompletedNum: 27),
          TaskExecuteModel(
              taskCycle: '半年检',
              taskNum: 40,
              taskUnCompletedNum: 33,
              taskCompletedNum: 7),
          TaskExecuteModel(
              taskCycle: '年检',
              taskNum: 50,
              taskUnCompletedNum: 23,
              taskCompletedNum: 27),
        ],
        taskDetailList = [
          TaskDetailModel(
              des: '任务描述1',
              type: '巡检任务',
              executor: 'xwz',
              progress: .2,
              cycle: '周检'),
          TaskDetailModel(
              des: '任务描述2',
              type: '日常任务',
              executor: 'zxc',
              progress: .6,
              cycle: '周检'),
          TaskDetailModel(
              des: '任务描述3',
              type: '日常任务',
              executor: 'xdd',
              progress: .7,
              cycle: '周检'),
          TaskDetailModel(
              des: '任务描述11',
              type: '补充任务',
              executor: 'xwz',
              progress: .7,
              cycle: '半月检'),
          TaskDetailModel(
              des: '任务描述22',
              type: '补充任务',
              executor: 'zzc',
              progress: .6,
              cycle: '半月检'),
          TaskDetailModel(
              des: '任务描述33',
              type: '补充任务',
              executor: 'xxd',
              progress: .4,
              cycle: '半月检'),
          TaskDetailModel(
              des: '任务描述111',
              type: '日常任务',
              executor: 'xez',
              progress: .5,
              cycle: '月检'),
          TaskDetailModel(
              des: '任务描述222',
              type: '日常任务',
              executor: 'zxc',
              progress: .6,
              cycle: '月检'),
          TaskDetailModel(
              des: '任务描述333',
              type: '日常任务',
              executor: 'xdd',
              progress: .7,
              cycle: '月检'),
          TaskDetailModel(
              des: '任务描述1',
              type: '日常任务',
              executor: 'xwz',
              progress: .5,
              cycle: '季度检'),
          TaskDetailModel(
              des: '任务描述2',
              type: '日常任务',
              executor: 'zxc',
              progress: .6,
              cycle: '季度检'),
          TaskDetailModel(
              des: '任务描述3',
              type: '日常任务',
              executor: 'xdd',
              progress: .7,
              cycle: '季度检'),
          TaskDetailModel(
              des: '任务描述1',
              type: '日常任务',
              executor: 'xwz',
              progress: .2,
              cycle: '半年检'),
          TaskDetailModel(
              des: '任务描述2',
              type: '日常任务',
              executor: 'zxc',
              progress: .60,
              cycle: '半年检'),
          TaskDetailModel(
              des: '任务描述3',
              type: '日常任务',
              executor: 'xdd',
              progress: .70,
              cycle: '半年检'),
          TaskDetailModel(
              des: '任务描述1',
              type: '日常任务',
              executor: 'xwz',
              progress: .50,
              cycle: '年检'),
          TaskDetailModel(
              des: '任务描述2',
              type: '日常任务',
              executor: '.zxc',
              progress: .60,
              cycle: '年检'),
          TaskDetailModel(
              des: '任务描述3',
              type: '日常任务',
              executor: 'xdd',
              progress: .70,
              cycle: '年检'),
        ],
        offlineDeviceFaultList = List.generate(20, (index) {
          return OfflineDeviceFaultMessage.generate(index.toString());
        }),
        onlineDeviceFaultUnSuredList = List.generate(20, (index) {
          return OnlineDeviceFaultUnsuredMessage.generate(index.toString());
        }),
        onlineDeviceFaultSuredList = List.generate(20, (index) {
          return OnlineDeviceFaultSuredMessage.generate(index.toString());
        }),
        processingDeviceFaultList = List.generate(20, (index) {
          return ProcessingDeviceFaultMessage.generate(index.toString());
        }),
        processedDeviceFaultList = List.generate(20, (index) {
          return ProcessedDeviceFaultMessage.generate(index.toString());
        }),
        buildingFloorList = List.generate(10, (index) {
          return BuildingFloorMessage.generate(index.toString());
        }),
        supervisorMessages = List.generate(20, (index) {
          return SupervisorMessageModel.generste(index.toString());
        });
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

///增加任务页面获取数据action
class AddTaskPageInitAction {
  List<Build> buildingList;
  List<InspectionSystem> systems;
  List<PersonnelMessage> departments;

  AddTaskPageInitAction(this.buildingList, this.systems, this.departments);
}

///初始化计划列表的action
class InitPlanListPageAction {
  PlanTaskListPageModel model;

  InitPlanListPageAction(this.model);
}

class DeviceSuperVisorNextPageAction{
  PlanTaskListPageModel model;

  DeviceSuperVisorNextPageAction(this.model);
}
