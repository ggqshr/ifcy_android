import 'package:ifcy/common/model/model.dart';

class InitPageStateAction {
  int faultNum;
  int taskRate;
  List<String> buildingList;
  String currentBuilding;
  List<int> bottomBadgeNumList;
  List<FireAlarmMessage> fireMessage;
  List<DeviceFaultMessage> deviceFaultMessage;

  InitPageStateAction({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
    this.fireMessage,
    this.deviceFaultMessage,
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
        ];
}

class OnChangeBuilding {
  String buildingName;

  OnChangeBuilding(this.buildingName);
}
