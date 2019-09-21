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

  TaskExecuteModel(
      {this.taskCycle,
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
  String id; //任务编号
  String des; //任务描述
  String type; //任务类型（巡检/任务）
  String executor; //任务执行者
  double progress; //任务执行进度
  String taskStartTime; //任务开始时间
  String taskEndTime; //任务结束时间
  String cycle; //任务周期描述

  TaskDetailModel(
      {this.id,
      this.des,
      this.type,
      this.executor,
      this.progress,
      this.taskStartTime,
      this.taskEndTime,
      this.cycle});

  @override
  String toString() {
    return 'TaskDetailModel{id: $id, des: $des, type: $type, executor: $executor, progress: $progress, taskStartTime: $taskStartTime, taskEndTime: $taskEndTime, cycle: $cycle}';
  }
}

Map<String, String> cycleToEnum = {
  "年检": "YEAR",
  "半年检": "HALF_YEAR",
  "季度检": "QUARTER",
  "月检": "MONTH",
  "周检": "WEEK",
  "日检": "DAY",
};
Map<String, String> enumToCycle = {
  "YEAR": "年检",
  "HALF_YEAR": "半年检",
  "QUARTER": "季度检",
  "MONTH": "月检",
  "WEEK": "周检",
  "DAY": "日检",
};

///任务周期实体类
class TaskCycleModel {
  String cycleId;
  String item;

  TaskCycleModel({this.cycleId, this.item});

  TaskCycleModel.fromString(String str) : item = enumToCycle[str];

  String get toEnum => cycleToEnum[item];

  @override
  String toString() {
    return 'TaskCycleModel{cycleId: $cycleId, item: $item}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskCycleModel &&
              runtimeType == other.runtimeType &&
              item == other.item;

  @override
  int get hashCode => item.hashCode;
}
