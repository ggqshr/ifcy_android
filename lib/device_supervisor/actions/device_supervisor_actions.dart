import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

class InitPageStateAction {
  int faultNum;
  int taskRate;
  List<String> buildingList;
  String currentBuilding;
  List<int> bottomBadgeNumList;
  List<FireAlarmMessage> fireMessage;
  List<DeviceFaultMessage> deviceFaultMessage;
  List<TaskInfoMessage> taskInfoMessage;
  List<DepartmentMessage> departmentMessage;
  List<TaskCycleModel> taskCycleMessages; //任务周期类别信息
  List<TaskExecuteModel> taskExecuteModel; //任务执行信息
  List<TaskDetailModel> taskDetailList; //任务列表信息
  List<TaskListViewModel> taskMessageViewList; //任务相关信息
  List<OfflineDeviceFaultMessage> offlineDeviceFaultList;//离线设备故障消息列表
  List<SupervisorMessageModel> supervisorMessages;//主管信息列表

  InitPageStateAction({
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
    this.taskMessageViewList,
    this.offlineDeviceFaultList,
    this.supervisorMessages,
  });

  InitPageStateAction.init()
      : faultNum = 0,
        taskRate = 23,
        buildingList = ["tt", "tt2"],
        currentBuilding = "tt",
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
        departmentMessage = [
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
        taskCycleMessages = [
          TaskCycleModel(cycleId: '1', item: '周检'),
          TaskCycleModel(cycleId: '2', item: '半月检'),
          TaskCycleModel(cycleId: '3', item: '月检'),
          TaskCycleModel(cycleId: '4', item: '季度检'),
          TaskCycleModel(cycleId: '5', item: '半年检'),
          TaskCycleModel(cycleId: '6', item: '年检'),
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
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述11',
                    type: '补充任务',
                    executor: 'xwz',
                    progress: .7,
                    cycle: '半月检'),
                TaskDetailModel(
                    des: '任务描述22',
                    type: '补充任务',
                    executor: 'zxc',
                    progress: .6,
                    cycle: '半月检'),
                TaskDetailModel(
                    des: '任务描述33',
                    type: '补充任务',
                    executor: 'xdd',
                    progress: .4,
                    cycle: '半月检'),
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
                TaskDetailModel(
                    des: '任务描述111',
                    type: '日常任务',
                    executor: 'xwz',
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
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
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
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
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
              ]),
          TaskListViewModel(
              taskExecuteModel: TaskExecuteModel(
                  taskNum: 10, taskUnCompletedNum: 3, taskCompletedNum: 7),
              taskDetailList: [
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
              ]),
        ],

  offlineDeviceFaultList=List.generate(20,(index){
    return OfflineDeviceFaultMessage.generate(index.toString());
  }),

  supervisorMessages=List.generate(20, (index){
    return SupervisorMessageModel.generste(index.toString());
  });
}

class OnChangeBuilding {
  String buildingName;

  OnChangeBuilding(this.buildingName);
}
