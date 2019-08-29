import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceStaffTaskListState extends Equatable {
  DeviceStaffTaskListState([List props = const <dynamic>[]]) : super(props);
}

class UnInitialDeviceStaffTaskListState extends DeviceStaffTaskListState {}

class LoadedDeviceStaffTaskListState extends DeviceStaffTaskListState {
  final InspectionTaskPageModel completeTask;
  final InspectionTaskPageModel unCompleteTask;
  final bool completeIsReachMax;
  final bool unCompleteIsReachMax;

  LoadedDeviceStaffTaskListState(
      {this.completeTask,
      this.unCompleteTask,
      this.completeIsReachMax,
      this.unCompleteIsReachMax})
      : super([
          completeTask,
          unCompleteTask,
          completeIsReachMax,
          unCompleteIsReachMax
        ]);

  LoadedDeviceStaffTaskListState copy(
      {completeTask,
      unCompleteTask,
      completeIsReachMax,
      unCompleteIsReachMax}) {
    return LoadedDeviceStaffTaskListState(
      completeTask: completeTask ?? this.completeTask,
      unCompleteTask: unCompleteTask ?? this.unCompleteTask,
      completeIsReachMax: completeIsReachMax ?? this.completeIsReachMax,
      unCompleteIsReachMax: unCompleteIsReachMax ?? this.unCompleteIsReachMax,
    );
  }
}

class LoadErrorDeviceStaffTaskList extends DeviceStaffTaskListState {}
