class InitPageStateAction {
  int faultNum;
  int taskRate;
  List<String> buildingList;
  String currentBuilding;
  List<int> bottomBadgeNumList;

  InitPageStateAction(
      {this.faultNum,
      this.taskRate,
      this.buildingList,
      this.currentBuilding,
      this.bottomBadgeNumList});

  InitPageStateAction.init()
      : faultNum = 0,
        taskRate = 23,
        buildingList = ["tt", "tt2"],
        currentBuilding = "tt",
        bottomBadgeNumList = [1, 0, 0, 0];
}

class OnChangeBuilding {
  String buildingName;

  OnChangeBuilding(this.buildingName);
}
