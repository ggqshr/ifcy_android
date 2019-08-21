part of "model.dart";

///@author ggq
///@description: 故障确认任务的数据model
///@date :2019/8/2 9:19
class FaultInspectionTask extends TaskInfo {
  String location;
  String deviceName;
  String deviceBellTime; //设备报警事件
  String taskCreateTime; //任务创建时间

  FaultInspectionTask(
    id,
    taskTitle,
    taskPeople,
    taskContent,
    taskStatus,
    this.deviceBellTime,
    this.deviceName,
    this.location,
    this.taskCreateTime,
  ) : super(
          id: id,
          taskTitle: taskTitle,
          taskPeople: taskPeople,
          taskContent: taskContent,
          taskStatus: taskStatus,
        );

  FaultInspectionTask.generate(
    id,
  )   : deviceBellTime = "$id${DateTime.now()}",
        deviceName = "设备$id",
        location = "大厦$id",
        taskCreateTime = "$id${DateTime.now()}",
        super(
          id: id,
          taskTitle: "任务$id",
          taskPeople: "people$id",
          taskContent: "任务内容$id",
          taskStatus: TaskStatus.values[int.parse(id) % 2],
        );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString() +
        "{location: $location, deviceName: $deviceName, deviceBellTime: $deviceBellTime, taskCreateTime: $taskCreateTime}");
  }
}
