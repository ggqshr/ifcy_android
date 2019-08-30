import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/add_plan_task_repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import './bloc.dart';

class AddTaskPlanBloc extends Bloc<AddTaskPlanEvent, AddTaskPlanState> {
  final AddTaskPlanRepositories addTaskPlanRepositories;
  final AuthorizationBloc bloc;

  AddTaskPlanBloc(this.bloc, [repo])
      : addTaskPlanRepositories = repo ?? AddTaskPlanRepositories();

  @override
  AddTaskPlanState get initialState => UnInitialAddTaskPlanState();

  @override
  Stream<AddTaskPlanState> mapEventToState(
    AddTaskPlanEvent event,
  ) async* {
    if (event is FetchData) {
      try {
        List<PersonnelMessage> persons =
            await addTaskPlanRepositories.getPersonnelMessage();
        List<TaskCycleModel> cycles =
            addTaskPlanRepositories.getTaskCycleModel();
        List<InspectionSystem> systems =
            await addTaskPlanRepositories.getSystem();
        yield AfterFetchedState.fetchSuccess(systems, cycles, persons,
            (bloc.currentState as Authenticated).currentBuild);
      } catch (e) {
        yield AfterFetchedState.fetchFault();
        rethrow;
      }
    }
    if (event is SubmitData) {
      yield (currentState as AfterFetchedState).submitting();
      try {
        bool isSuccess =
            await addTaskPlanRepositories.submitting(event.taskPlanEntity);
        if (isSuccess) {
          yield (currentState as AfterFetchedState).submittingSuccess();
        } else {
          yield (currentState as AfterFetchedState).submittingFault();
        }
      } catch (e) {
        yield (currentState as AfterFetchedState).submittingFault();
        rethrow;
      }
    }
  }
}
