///@author ggq
///@description:
///@date :2019/8/2 15:34
part of 'device_staff_model.dart';

class RegularInspectionViewModel
    extends TaskInfoViewModel<RegularInspectionTask> {
  RegularInspectionViewModel({
    completeTasks,
    unCompleteTasks,
    onRefreshCall,
  }) : super(
            completeTasks: completeTasks,
            unCompleteTasks: unCompleteTasks,
            onRefreshCall: onRefreshCall);
}
