export 'fire_alarm_message.dart';
export 'device_fault_message.dart';
export 'task_info_message.dart';
export 'regular_inspection_model.dart';
export 'additional_inspection_model.dart';
export 'fault_inspection_model.dart';

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
