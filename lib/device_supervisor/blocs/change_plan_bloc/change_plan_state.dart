import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangePlanState extends Equatable {
  ChangePlanState([List props = const <dynamic>[]]) : super(props);
}

class LoadingChangePlanState extends ChangePlanState {}

class LoadedChangePlanState extends ChangePlanState {
  final TaskPlanEntity model;
  final Build currentBuilding;
  final List<InspectionSystem> systems;
  final List<PersonnelMessage> people;
  final List<TaskCycleModel> cycles;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFault;

  LoadedChangePlanState({
    this.model,
    this.isSubmitting,
    this.isFault,
    this.isSuccess,
    this.systems,
    this.currentBuilding,
    this.cycles,
    this.people,
  }) : super([
          model,
          isSubmitting,
          isSuccess,
          isFault,
          systems,
          currentBuilding,
          cycles,
          people
        ]);

  LoadedChangePlanState.init({
    TaskPlanEntity model,
    Build currentBuilding,
    List<InspectionSystem> systems,
    List<PersonnelMessage> people,
    List<TaskCycleModel> cycles,
  })  : isFault = false,
        model = model,
        isSuccess = false,
        isSubmitting = false,
        currentBuilding = currentBuilding,
        systems = systems,
        people = people,
        cycles = cycles;

  LoadedChangePlanState submit() {
    return new LoadedChangePlanState(
      model: this.model,
      isSubmitting: true,
      isSuccess: false,
      isFault: false,
      currentBuilding: this.currentBuilding,
      systems: this.systems,
      people: this.people,
      cycles: this.cycles,
    );
  }

  LoadedChangePlanState success() {
    return new LoadedChangePlanState(
      model: this.model,
      isSubmitting: false,
      isSuccess: true,
      isFault: false,
      currentBuilding: this.currentBuilding,
      systems: this.systems,
      people: this.people,
      cycles: this.cycles,
    );
  }

  LoadedChangePlanState fault() {
    return new LoadedChangePlanState(
      model: this.model,
      isSubmitting: false,
      isSuccess: false,
      isFault: true,
      currentBuilding: this.currentBuilding,
      systems: this.systems,
      people: this.people,
      cycles: this.cycles,
    );
  }
}

class LoadErrorChangePlanState extends ChangePlanState {}
