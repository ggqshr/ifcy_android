import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model.dart';

part 'regular_inspection_task.g.dart';

///@author ggq
///@description: 定期巡检任务的数据model
///@date :2019/8/2 9:19
class RegularInspectionTask extends TaskInfo {
  RegularInspectionTask(
    id,
    taskTitle,
    taskPeople,
    taskContent,
    taskTime,
    taskStatus,
  ) : super(
          id: id,
          taskTitle: taskTitle,
          taskPeople: taskPeople,
          taskContent: taskContent,
          taskTime: taskTime,
          taskStatus: taskStatus,
        );

  RegularInspectionTask.generate(id)
      : super(
          id: id,
          taskTitle: "任务$id",
          taskPeople: "people$id",
          taskContent: "任务内容$id",
          taskTime: "${DateTime.now()}",
          taskStatus: TaskStatus.values[int.parse(id) % 2],
        );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString());
  }
}

//日常巡检任务详情
@JsonSerializable()
class RegularInspectionTaskDetail extends TaskInfoDetail with ChangeNotifier {
  RegularInspectionTaskDetail({
    deviceName,
    deviceId,
    deviceType,
    inspectionRequire,
    InspectionResultType inspectionResultType,
    ProcessType processType,
    noteText,
    images,
    TaskStatus taskStatus,
    taskArea,
    taskFloor,
  }) : super(
          deviceName: deviceName,
          deviceId: deviceId,
          deviceType: deviceType,
          inspectionRequire: inspectionRequire,
          inspectionResultType: inspectionResultType,
          processType: processType,
          noteText: noteText,
          images: images,
          taskStatus: taskStatus,
          taskArea: taskArea,
          taskFloor: taskFloor,
        );

  RegularInspectionTaskDetail.generate(id)
      : super(
          deviceName: "设备$id",
          deviceId: id,
          deviceType: "设备类别$id",
          inspectionRequire: "检查要求$id",
          inspectionResultType: InspectionResultType.values[int.parse(id) % 3],
          processType: ProcessType.values[int.parse(id) % 3],
          noteText: "备注$id",
          images: [],
          taskStatus: TaskStatus.values[int.parse(id) % 2],
          taskArea: "${Random().nextInt(12)}",
          taskFloor: "${Random().nextInt(30)}",
        );

  factory RegularInspectionTaskDetail.fromJson(Map<String, dynamic> json) =>
      _$RegularInspectionTaskDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RegularInspectionTaskDetailToJson(this);

  void onResultChangeCall(value) {
    inspectionResultType = parseEnumType(value);
    notifyListeners();
  }

  void onProcessChangeCall(value) {
    processType = parseEnumType(value);
    notifyListeners();
  }

  void addToImages(value) {
    images.add(value);
    notifyListeners();
  }

  void removeFromImages(value) {
    images.remove(value);
    notifyListeners();
  }

  void updateTaskStatus(TaskStatus status) {
    taskStatus = status;
    notifyListeners();
  }

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString());
  }
}
