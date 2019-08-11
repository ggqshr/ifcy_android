part of 'device_supervisor_model.dart';

class TaskInfoModel {
  int messageNum;
  List<TaskInfoMessage> completedTask; //已完成
  List<TaskInfoMessage> uncompletedTask; //未完成

  TaskInfoModel({this.messageNum, this.completedTask, this.uncompletedTask});
}


///任务执行情况数据统计类
class TaskExecuteModel {
  String taskCycle;
  int taskNum;
  int taskCompletedNum;
  int taskUnCompletedNum;

  TaskExecuteModel({
    this.taskCycle,
    this.taskNum,
    this.taskCompletedNum,
    this.taskUnCompletedNum});

  @override
  String toString() {
    return 'TaskExecuteModel{taskCycle:$taskCycle,taskNum: $taskNum, taskCompletedNum: $taskCompletedNum, taskUnCompletedNum: $taskUnCompletedNum}';
  }
}

/// 单个任务详情类
class TaskDetailModel {

  String id;//任务编号
  String des;//任务描述
  String type;//任务类型（巡检/任务）
  String executor;//任务执行者
  double progress;//任务执行进度
  String taskStartTime;//任务开始时间
  String taskEndTime;//任务结束时间
  String cycle;//任务周期描述

  TaskDetailModel({this.id,this.des, this.type, this.executor, this.progress,this.taskStartTime,this.taskEndTime,this.cycle});

  @override
  String toString() {
    return 'TaskDetailModel{id: $id, des: $des, type: $type, executor: $executor, progress: $progress, taskStartTime: $taskStartTime, taskEndTime: $taskEndTime, cycle: $cycle}';
  }

}

///任务周期实体类
class TaskCycleModel {
  String cycleId;
  String item;

  TaskCycleModel({this.cycleId, this.item});

  @override
  String toString() {
    return 'TaskCycleModel{cycleId: $cycleId, item: $item}';
  }


}
