import 'dart:math';

import 'model.dart';

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
class RegularInspectionTaskDetail extends TaskInfoDetail {
  RegularInspectionTaskDetail({
    deviceName,
    deviceId,
    deviceType,
    inspectionRequire,
    inspectionResultType,
    processType,
    noteText,
    images,
  }) : super(
          deviceName: deviceName,
          deviceId: deviceId,
          deviceType: deviceType,
          inspectionRequire: inspectionRequire,
          inspectionResultType: inspectionResultType,
          processType: processType,
          noteText: noteText,
          images: images,
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
        );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString());
  }
}