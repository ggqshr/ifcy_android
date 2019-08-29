///@author ggq
///@description: 巡检任务的分页数据实体
///@date :2019/8/29 10:15
part of "device_staff_model.dart";

Map taskStatusToString = {
  TaskStatus.completed: "COMPLETED",
  TaskStatus.uncompleted: "UNCOMPLETED",
  TaskStatus.out_time_completed: "OUT_TIME_COMPLETED",
  TaskStatus.running: "RUNNING",
  TaskStatus.unreached: "UNREACHED",
};
Map stringToTaskStatus = taskStatusToString.map((k, v) => MapEntry(v, k));

String taskStatusToJson(TaskStatus status) {
  if (status == null) return null;
  return taskStatusToString[status];
}

TaskStatus taskStatusFromJson(String status) {
  if (status == null) return null;
  return stringToTaskStatus[status];
}

///计划或者任务的实体类
@JsonSerializable()
class InspectionTaskModel {
  ///id
  String id;

  ///任务名称
  String name;
  @JsonKey(
      name: "task_status",
      toJson: taskStatusToJson,
      fromJson: taskStatusFromJson)
  TaskStatus taskStatus;

  ///任务的备注
  @JsonKey(name: "comment")
  String noteText;

  ///要检查的设备数目
  @JsonKey(name: "device_num")
  String deviceNum;

  ///已检查的设备数目
  @JsonKey(name: "checked_device_num")
  String checkedDeviceNum;

  ///检查的楼层的楼层
  @JsonKey(name: "check_building_floor_list")
  List<FloorEntity> currentFloor;

  ///检察系统
  @JsonKey(name: "check_system_list")
  List<InspectionSystem> selectedSystem;

  ///todo 设备列表

  ///任务独有

  ///开始时间
  @JsonKey(name: "start_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime startTime;

  ///结束时间
  @JsonKey(name: "end_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime endTime;

  InspectionTaskModel(
      this.id,
      this.name,
      this.taskStatus,
      this.noteText,
      this.deviceNum,
      this.checkedDeviceNum,
      this.currentFloor,
      this.selectedSystem,
      this.startTime,
      this.endTime);

  factory InspectionTaskModel.fromJson(Map<String, dynamic> json) =>
      _$InspectionTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$InspectionTaskModelToJson(this);

  @override
  String toString() {
    return 'InspectionTaskModel{id: $id, name: $name, taskStatus: $taskStatus, noteText: $noteText, deviceNum: $deviceNum, checkedDeviceNum: $checkedDeviceNum, currentFloor: $currentFloor, selectedSystem: $selectedSystem, startTime: $startTime, endTime: $endTime}';
  }
}

@JsonSerializable()
class InspectionTaskPageModel {
  @JsonKey(name: "content")
  List<InspectionTaskModel> taskInfoList;

  ///当前页数
  @JsonKey(name: "number")
  int currentPageNum;

  ///总页数
  @JsonKey(name: "total_pages")
  int totalPageNum;

  ///总元素个数
  @JsonKey(name: "total_elements")
  int totalElementNum;

  InspectionTaskPageModel nextPage(InspectionTaskPageModel pageModel) {
    return InspectionTaskPageModel(
      taskInfoList: this.taskInfoList + pageModel.taskInfoList,
      currentPageNum: pageModel.currentPageNum + 1,
      totalElementNum: this.totalPageNum,
      totalPageNum: this.totalPageNum,
    );
  }

  InspectionTaskPageModel copy(InspectionTaskPageModel pageModel) {
    return InspectionTaskPageModel(
      taskInfoList: this.taskInfoList + pageModel.taskInfoList,
      currentPageNum: pageModel.currentPageNum,
      totalElementNum: this.totalPageNum,
      totalPageNum: this.totalPageNum,
    );
  }

  InspectionTaskPageModel(
      {this.taskInfoList,
      this.currentPageNum,
      this.totalPageNum,
      this.totalElementNum});

  factory InspectionTaskPageModel.fromJson(Map<String, dynamic> json) =>
      _$InspectionTaskPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$InspectionTaskPageModelToJson(this);

  @override
  String toString() {
    return 'InspectionTaskPageModel{taskInfo: $taskInfoList, currentPageNum: $currentPageNum, totalPageNum: $totalPageNum, totalElementNum: $totalElementNum}';
  }
}
