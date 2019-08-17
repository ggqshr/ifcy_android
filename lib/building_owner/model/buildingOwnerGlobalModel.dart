import 'package:ifcy/common/model/model.dart';

class BuildingOwnerModel {
  int fireNum; //火警数
  int faultNum; //故障数
  int taskProgress; //巡检进度
  List<String> buildingList; //大厦列表
  String currentBuilding; //当前选中的大厦
  List<FireAlarmMessage> fireAlarmMessages; //火警消息
  List<DeviceFaultMessage> deviceFaultMessages; //设备故障消息
//  List<int> bottomBadgeNumList; // 底部导航栏的徽章数

  BuildingOwnerModel({
    this.fireNum,
    this.faultNum,
    this.taskProgress,
    this.buildingList,
    this.currentBuilding,
    this.fireAlarmMessages,
    this.deviceFaultMessages,
    //this.bottomBadgeNumList,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingOwnerModel &&
          runtimeType == other.runtimeType &&
          fireNum == other.fireNum &&
          faultNum == other.faultNum &&
          taskProgress == other.taskProgress &&
          buildingList == other.buildingList &&
          currentBuilding == other.currentBuilding;
  //bottomBadgeNumList == other.bottomBadgeNumList;

  @override
  int get hashCode =>
      fireNum.hashCode ^
      faultNum.hashCode ^
      taskProgress.hashCode ^
      buildingList.hashCode ^
      currentBuilding.hashCode;
  // bottomBadgeNumList.hashCode;

}

//业主首页视图模型
class BuildingOwnerMainViewModel {
  int fireNum;
  int faultNum;
  int taskProgress;
  List<FireAlarmMessage> fireAlarmMessageList;
  List<DeviceFaultMessage> deviceFaultMessageList;

  BuildingOwnerMainViewModel(
      {this.fireNum,
      this.faultNum,
      this.taskProgress,
      this.fireAlarmMessageList,
      this.deviceFaultMessageList});
}

//业主页面AppBar视图模型
class OwnerAppBarViewModel {
  List<String> buildingList;
  String curBuilding;

  OwnerAppBarViewModel({this.buildingList, this.curBuilding});

}
