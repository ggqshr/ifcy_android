import 'package:ifcy/common/model/model.dart';

class InitOwnerPageStateAction{
  int fireNum;//火警数
  int faultNum;//故障数
  int taskProgress;//巡检进度
  List<String> buildingList; //大厦列表
  String currentBuilding; //当前选中的大厦
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages;//设备故障消息

  InitOwnerPageStateAction({
    this.fireNum,
    this.faultNum,
    this.taskProgress,
    this.buildingList,
    this.currentBuilding,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
});

  InitOwnerPageStateAction.init()
      : fireNum =2,
        faultNum = 0,
        taskProgress = 20,
        buildingList = ["tt", "tt2"],
        currentBuilding = "tt";
}

class OnChangeBuilding {
  String buildingName;
  OnChangeBuilding(this.buildingName);
}