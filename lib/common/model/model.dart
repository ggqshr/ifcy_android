export 'fire_alarm_message.dart';
export 'device_fault_message.dart';
export 'task_info_message.dart';
export 'personnel_message.dart';
export 'supervisior_message.dart';
export 'regular_inspection_task.dart';
export 'additional_inspection_task.dart';
export 'fault_inspection_task.dart';

export 'offline_device_fault_message.dart';
export 'online_device_fault_sured_message.dart';
export 'offline_device_fault_message.dart';

import 'package:ifcy/common/model/task_info_message.dart';

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

///故障消息的抽象类
abstract class FaultInfo{
  String id;//故障消息id
  String deviceName;//故障设备名称
  String deviceType;//故障设备类型
  String deviceLocation;//故障设备位置

  FaultInfo({
    this.id,
    this.deviceName,
    this.deviceType,
    this.deviceLocation,
});

  String toPrint(String className){
    return '$className{id:$id,deviceName:$deviceName,deviceType:$deviceType,deviceLocation:$deviceLocation}';
  }

}