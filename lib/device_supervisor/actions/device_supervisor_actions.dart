import 'package:ifcy/common/model/model.dart';

class InitPageStateAction {
  int faultNum;
  int taskRate;
  List<String> buildingList;
  String currentBuilding;
  List<int> bottomBadgeNumList;
  List<FireAlarmMessage> fireMessage;
  List<DeviceFaultMessage> deviceFaultMessage;
  List<TaskInfoMessage> taskInfoMessage;
  List<SupervisorMessageModel> supervisorMessgae;
  List<DepartmentMessage> departmentMessage;

  InitPageStateAction({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireMessage,
    this.deviceFaultMessage,
    this.taskInfoMessage,
    this.supervisorMessgae,
    this.departmentMessage,
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
        supervisorMessgae = [
          SupervisorMessageModel(name: '主管1'),
          SupervisorMessageModel(name: '主管2'),
          SupervisorMessageModel(name: '主管3'),
          SupervisorMessageModel(name: '主管4')
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
        ];
}

class OnChangeBuilding {
  String buildingName;

  OnChangeBuilding(this.buildingName);
}
