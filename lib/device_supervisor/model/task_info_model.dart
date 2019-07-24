part of 'device_supervisor_model.dart';

class TaskInfoModel {
  int messageNum;
  List<TaskInfoMessage> completedTask; //已完成
  List<TaskInfoMessage> uncompletedTask; //未完成

  TaskInfoModel({this.messageNum, this.completedTask, this.uncompletedTask});
}
