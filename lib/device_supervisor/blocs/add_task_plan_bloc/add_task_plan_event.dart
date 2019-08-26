import 'package:equatable/equatable.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddTaskPlanEvent extends Equatable {
  AddTaskPlanEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchData extends AddTaskPlanEvent {}

class SubmitData extends AddTaskPlanEvent {
  final TaskPlanEntity taskPlanEntity;

  SubmitData(this.taskPlanEntity) : super([taskPlanEntity]);

  @override
  String toString() {
    return 'SubmitData{taskPlanEntity: $taskPlanEntity}';
  }
}
