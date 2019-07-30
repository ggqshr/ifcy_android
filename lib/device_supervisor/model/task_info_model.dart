part of 'device_supervisor_model.dart';

class TaskInfoModel {
  int messageNum;
  List<TaskInfoMessage> completedTask; //已完成
  List<TaskInfoMessage> uncompletedTask; //未完成

  TaskInfoModel({this.messageNum, this.completedTask, this.uncompletedTask});
}

class TaskListModel{
  String choice;
  //List<TaskExecuteModel> taskExecuteModel;//任务执行情况统计
  List<TaskDetailModel> taskDetailList;//任务详细列表

  TaskListModel({this.choice,this.taskDetailList});
}


///任务完成情况统计
class TaskExecuteModel{
  String choice;
  int taskNum;
  int taskCompletedNum;
  int taskUnCompletedNum;

  TaskExecuteModel({this.choice,this.taskNum,this.taskCompletedNum,this.taskUnCompletedNum});
}


class TaskDetailModel{
  String des;
  String type;
  String executor;
  int progress;
  TaskDetailModel({this.des,this.type,this.executor,this.progress});
}

