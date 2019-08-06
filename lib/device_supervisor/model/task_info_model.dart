part of 'device_supervisor_model.dart';

class TaskInfoModel {
  int messageNum;
  List<TaskInfoMessage> completedTask; //已完成
  List<TaskInfoMessage> uncompletedTask; //未完成

  TaskInfoModel({this.messageNum, this.completedTask, this.uncompletedTask});
}

///任务执行视图类
class TaskListViewModel {

  TaskExecuteModel taskExecuteModel;//任务执行情况统计
  List<TaskDetailModel> taskDetailList; //任务详细列表

  TaskListViewModel({this.taskExecuteModel,this.taskDetailList});

  @override
  String toString() {
    return 'TaskListViewModel{taskExecuteModel: $taskExecuteModel, taskDetailList: $taskDetailList}';
  }

}

///任务执行情况数据统计类
class TaskExecuteModel {
  int taskNum;
  int taskCompletedNum;
  int taskUnCompletedNum;

  TaskExecuteModel({
    this.taskNum,
    this.taskCompletedNum,
    this.taskUnCompletedNum});

  @override
  String toString() {
    return 'TaskExecuteModel{taskNum: $taskNum, taskCompletedNum: $taskCompletedNum, taskUnCompletedNum: $taskUnCompletedNum}';
  }


}

/// 单个任务详情类
class TaskDetailModel {
  String des;
  String type;
  String executor;
  double progress;
  String cycle;//周期

  TaskDetailModel({this.des, this.type, this.executor, this.progress,this.cycle});

  @override
  String toString() {
    return 'TaskDetailModel{des: $des, type: $type, executor: $executor, progress: $progress, cycle: $cycle}';
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
