import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddTaskPlanState extends Equatable {
  AddTaskPlanState([List props = const <dynamic>[]]) : super(props);
}

class UnInitialAddTaskPlanState extends AddTaskPlanState {}

class AfterFetchedState extends AddTaskPlanState {
  final bool isFetchSuccess;
  final bool isSubmitting;
  final bool isSubmittingSuccess;
  final bool isSubmittingFault;
  final List<InspectionSystem> systems;
  final List<TaskCycleModel> cycleModel;
  final List<PersonnelMessage> personnelMessage;
  final Build thisBuild;

  AfterFetchedState(
      this.isFetchSuccess,
      this.systems,
      this.cycleModel,
      this.personnelMessage,
      this.thisBuild,
      this.isSubmittingFault,
      this.isSubmittingSuccess,
      this.isSubmitting)
      : super([systems, cycleModel, personnelMessage, thisBuild,isFetchSuccess,isSubmittingFault,isSubmitting,isSubmittingSuccess,isSubmittingFault]);

  AfterFetchedState.fetchSuccess(
      this.systems, this.cycleModel, this.personnelMessage, this.thisBuild)
      : isFetchSuccess = true,
        isSubmitting = false,
        isSubmittingSuccess = false,
        isSubmittingFault = false;

  AfterFetchedState.fetchFault()
      : isFetchSuccess = false,
        systems = null,
        cycleModel = null,
        thisBuild = null,
        personnelMessage = null,
        isSubmitting = false,
        isSubmittingSuccess = false,
        isSubmittingFault = false;

  AfterFetchedState submitting() {
    return AfterFetchedState(this.isFetchSuccess, this.systems, this.cycleModel,
        this.personnelMessage, this.thisBuild, false, false, true);
  }

  AfterFetchedState submittingSuccess() {
    return AfterFetchedState(this.isFetchSuccess, this.systems, this.cycleModel,
        this.personnelMessage, this.thisBuild, false, true, false);
  }

  AfterFetchedState submittingFault() {
    return AfterFetchedState(this.isFetchSuccess, this.systems, this.cycleModel,
        this.personnelMessage, this.thisBuild, true, false, false);
  }

  @override
  String toString() {
    return 'AfterFetchedState{systems: $systems, cycleModel: $cycleModel, personnelMessage: $personnelMessage}';
  }
}

