part 'monitor_page_model.dart';

class DeviceSupervisorModel {
  int faultNum; //故障数
  int taskRate; //任务完成进度
  List<String> buildingList; //大厦列表
  String currentBuilding; //当前选中的大厦
  List<int> bottomBadgeNumList; // 底部导航栏的徽章数

  DeviceSupervisorModel({
    this.faultNum,
    this.taskRate,
    this.buildingList,
    this.currentBuilding,
    this.bottomBadgeNumList,
  });

  DeviceSupervisorModel.init()
      : faultNum = 0,
        taskRate = 0,
        buildingList = ["tt", "tt2"],
        currentBuilding = "tt",
        bottomBadgeNumList = [0, 0, 0, 0];

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
