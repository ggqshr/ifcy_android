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
