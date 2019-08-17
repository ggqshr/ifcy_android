import 'package:ifcy/common/model/model.dart';

part 'regular_inspection_model.dart';

part 'additional_inspection_model.dart';

part 'fault_inspection_model.dart';

part 'device_staff_appbar_model.dart';

///@author ggq
///@description: 维保工作人员的模块model
///@date :2019/8/2 8:58
class DeviceStaffModel {
  List<int> badgeNumList; //底部导航栏微张数
  List<RegularInspectionTask> regularTasks; //日常巡查任务
  List<AdditionalInspectionTask> additionalTasks; //补充任务
  List<FaultInspectionTask> faultTasks; // 故障确认任务
  List<Build> buildingList = [Build(buildId: null, buildName: "所有大厦")]; //大厦列表
  Build currentBuilding; //当前选中的大厦

  DeviceStaffModel({
    this.badgeNumList,
    this.regularTasks,
    this.additionalTasks,
    this.faultTasks,
    this.buildingList,
    this.currentBuilding,
  });

  DeviceStaffModel.init()
      : badgeNumList = [1, 2],
        regularTasks = List.generate(20, (index) {
          return RegularInspectionTask.generate(index.toString());
        }),
        additionalTasks = List.generate(20, (index) {
          return AdditionalInspectionTask.generate(index.toString());
        }),
        faultTasks = List.generate(20, (index) {
          return FaultInspectionTask.generate(index.toString());
        }),
        buildingList = [Build(buildId: null, buildName: "所有大厦")],
        currentBuilding = Build(buildId: null, buildName: "所有大厦");
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
