///@author ggq
///@description:
///@date :2019/8/2 16:18
part of 'device_staff_model.dart';

class FaultInspectionModel {
  List<FaultInspectionTask> tasks;
  Function onRefreshCall;

  FaultInspectionModel({this.tasks, this.onRefreshCall});
}
