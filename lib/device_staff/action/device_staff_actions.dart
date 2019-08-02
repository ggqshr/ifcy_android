import 'package:ifcy/common/model/model.dart';

class InitDeviceStaffStateAction {
  List<int> badgeNumList; //底部导航栏微张数
  List<RegularInspectionModel> regularTasks; //日常巡查任务
  List<AdditionalInspectionModel> additionalTasks; //补充任务
  List<FaultInspectionModel> faultTasks; // 故障确认任务

  InitDeviceStaffStateAction(
      {this.badgeNumList,
      this.regularTasks,
      this.additionalTasks,
      this.faultTasks});

  InitDeviceStaffStateAction.init()
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
