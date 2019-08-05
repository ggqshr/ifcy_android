export 'fire_alarm_message.dart';
export 'device_fault_message.dart';
export 'task_info_message.dart';
export 'regular_inspection_task.dart';
export 'additional_inspection_task.dart';
export 'fault_inspection_task.dart';

import 'dart:io';

import 'package:ifcy/common/model/task_info_message.dart';

///检查结果的类型
enum InspectionResultType {
  normal, //正常
  defect, //缺陷
  fault, //故障
}

Map<int, String> inspectionResultTypeMap = {
  0: "正常",
  1: "缺陷",
  2: "故障",
};

///根据传入的类型，将枚举类和字符串互转
parseEnumType<S>(S type) {
  if (!(type is String)) {
    if (type is InspectionResultType) {
      return inspectionResultTypeMap[
          InspectionResultType.values.indexOf((type as InspectionResultType))];
    } else if (type is ProcessType) {
      return processTypeMap[ProcessType.values.indexOf((type as ProcessType))];
    }
  } else {
    if (inspectionResultTypeMap.containsValue(type as String)) {
      int thisIndex = inspectionResultTypeMap.keys.toList()[
          inspectionResultTypeMap.values.toList().indexOf(type as String)];
      return InspectionResultType.values[thisIndex];
    } else if (processTypeMap.containsValue(type as String)) {
      int thisIndex = processTypeMap.keys
          .toList()[processTypeMap.values.toList().indexOf(type as String)];
      return ProcessType.values[thisIndex];
    }
  }
}

///处理措施
enum ProcessType {
  repair, //现场维修
  requireChange, //申请更换
  requireRepair, //申报维修
}

Map<int, String> processTypeMap = {
  0: "现场维修",
  1: "申请更换",
  2: "申报维修",
};

abstract class TaskInfo {
  String id; //任务id
  String taskTitle; //任务标题
  String taskPeople; //任务执行人
  String taskContent; //任务内容
  String taskTime; //任务时间限制
  TaskStatus taskStatus; //任务执行状态，分为是否执行完毕

  TaskInfo({
    this.id,
    this.taskTitle,
    this.taskPeople,
    this.taskContent,
    this.taskTime,
    this.taskStatus,
  });

  String toPrint(String className) {
    return '$className{id: $id, taskTitle: $taskTitle, taskPeople: $taskPeople, taskContent: $taskContent, taskTime: $taskTime, taskStatus: $taskStatus}';
  }
}

abstract class TaskInfoDetail {
  String deviceName; //设备名
  String deviceId; //设备ID
  String deviceType; //设备类别
  String inspectionRequire; //检查要求
  InspectionResultType inspectionResultType; //检查结果的类型
  ProcessType processType; //处理的措施
  String noteText; //备注
  List<File> images; //上传的图片

  TaskInfoDetail({
    this.deviceName,
    this.deviceId,
    this.deviceType,
    this.inspectionRequire,
    this.inspectionResultType,
    this.processType,
    this.noteText,
    this.images,
  });

  String toPrint(String className) {
    return '$className{deviceName: $deviceName, deviceId: $deviceId, deviceType: $deviceType, inspectionRequire: $inspectionRequire, inspectionResultType: $inspectionResultType, processType: $processType, noteText: $noteText, images: $images}';
  }
}
