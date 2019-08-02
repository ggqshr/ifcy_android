import 'package:ifcy/common/model/model.dart';

part 'regular_inspection_model.dart';

///@author ggq
///@description: 维保工作人员的模块model
///@date :2019/8/2 8:58
class DeviceStaffModel {
  List<int> badgeNumList; //底部导航栏微张数
  List<RegularInspectionModel> regularTasks; //日常巡查任务
  List<AdditionalInspectionModel> additionalTasks; //补充任务
  List<FaultInspectionModel> faultTasks; // 故障确认任务

  DeviceStaffModel(
      {this.badgeNumList,
      this.regularTasks,
      this.additionalTasks,
      this.faultTasks});

  DeviceStaffModel.init()
      : badgeNumList = [1, 2],
        regularTasks = List.generate(20, (index) {
          return RegularInspectionModel.generate(index.toString());
        }),
        additionalTasks = List.generate(20, (index) {
          return AdditionalInspectionModel.generate(index.toString());
        }),
        faultTasks = List.generate(20, (index) {
          return FaultInspectionModel.generate(index.toString());
        });
}

abstract class TaskInfoViewModel<T> {
  List<T> completeTasks;
  List<T> unCompleteTasks;
  Function onRefreshCall;

  TaskInfoViewModel({
    this.completeTasks,
    this.unCompleteTasks,
    this.onRefreshCall,
  });
}
