import 'package:equatable/equatable.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangePlanEvent extends Equatable {
  ChangePlanEvent([List props = const <dynamic>[]]) : super(props);
}

class InitPageEvent extends ChangePlanEvent {}

class SubmitChangeEvent extends ChangePlanEvent {
  final TaskPlanEntity model;

  SubmitChangeEvent(this.model) : super([model]);
}
