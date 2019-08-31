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
  @JsonKey(name: "check_device_list")
  List<InspectionDeviceModel> devices;

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

enum CheckResult {
  ///正常
  running,

  ///故障
  fault,
}

Map<int, String> checkStatusTypeMap = {
  0: "已检查",
  1: "未检查",
  2: "未上传",
};

enum CheckStatus {
  ///已经检查完毕
  checked,

  ///未检查
  uncheck,

  ///本地已检查，但未上传
  localCheck,
}

Map<int, String> checkResultTypeMap = {
  0: "正常",
  1: "故障",
};

Map<CheckResult, String> checkResultToString = {
  CheckResult.running: "RUNNING",
  CheckResult.fault: "FAULT",
};
Map<String, CheckResult> stringToCheckResult =
    checkResultToString.map((k, v) => MapEntry(v, k));

String checkResultToJson(CheckResult checkResult) =>
    checkResultToString[checkResult];

CheckResult checkResultFromJson(String json) =>
    stringToCheckResult[json ?? "RUNNING"];

bool checkStatusToJson(CheckStatus status) => status == CheckStatus.checked;

CheckStatus checkStatusFromJson(bool value) =>
    value ? CheckStatus.checked : CheckStatus.uncheck;

@JsonSerializable()
class InspectionDeviceModel {
  ///设备名
  String name;

  ///设备的id
  String id;

  ///设备的编码
  String code;

  ///备注
  String comment;

  ///是否被检查过
  @JsonKey(
    name: "checked",
    toJson: checkStatusToJson,
    fromJson: checkStatusFromJson,
  )
  CheckStatus checkStatus;

  ///检查的结果
  @JsonKey(
    name: "check_device_status",
    toJson: checkResultToJson,
    fromJson: checkResultFromJson,
  )
  CheckResult checkResult;

  ///设备所属楼层
  @JsonKey(name: "building_floor_id")
  String buildingFloorId;

  ///图片1
  String pic1;

  ///图片2
  String pic2;

  ///图片列表
  List<String> get images => [pic1, pic2];

  InspectionDeviceModel(
      {this.name,
      this.id,
      this.code,
      this.comment,
      this.checkStatus,
      this.checkResult,
      this.buildingFloorId,
      this.pic1,
      this.pic2});

  InspectionDeviceModel.fromData(DeviceData data)
      : name = data.name,
        id = data.id,
        code = data.code,
        comment = data.comment,
        checkStatus = parseEnumType(data.checkStatus),
        checkResult = parseEnumType(data.checkResult),
        buildingFloorId = data.buildingFloorId,
        pic1 = jsonDecode(data.images)[0],
        pic2 = jsonDecode(data.images)[1];

  DeviceData toData(String taskId) {
    return DeviceData(
      taskId: taskId,
      name: this.name,
      id: this.id,
      code: this.code,
      comment: this.comment ?? "",
      checkStatus: parseEnumType(this.checkStatus),
      checkResult: parseEnumType(this.checkResult),
      buildingFloorId: this.buildingFloorId,
      images: jsonEncode([this.pic1, this.pic2]),
    );
  }

  InspectionDeviceModel copy({comment, checkResult, pic1, pic2, index}) {
    return InspectionDeviceModel(
        name: this.name,
        id: this.id,
        code: this.code,
        comment: comment ?? this.comment,
        checkStatus: this.checkStatus,
        checkResult: checkResult ?? this.checkResult,
        buildingFloorId: this.buildingFloorId,
        pic1: index == 0 ? pic1 : this.pic1,
        pic2: index == 1 ? pic2 : this.pic2);
  }

  factory InspectionDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$InspectionDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InspectionDeviceModelToJson(this);

  @override
  String toString() {
    return 'InspectionDeviceModel{name: $name, id: $id, code: $code, comment: $comment, checkStatus: $checkStatus, checkResult: $checkResult, buildingFloorId: $buildingFloorId, pic1: $pic1, pic2: $pic2}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InspectionDeviceModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              id == other.id &&
              code == other.code &&
              comment == other.comment &&
              checkStatus == other.checkStatus &&
              checkResult == other.checkResult &&
              buildingFloorId == other.buildingFloorId &&
              pic1 == other.pic1 &&
              pic2 == other.pic2;

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      code.hashCode ^
      comment.hashCode ^
      checkStatus.hashCode ^
      checkResult.hashCode ^
      buildingFloorId.hashCode ^
      pic1.hashCode ^
      pic2.hashCode;


}
