import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';

import './bloc.dart';

class ChangePlanBloc extends Bloc<ChangePlanEvent, ChangePlanState> {
  final PlanListRepositories repositories;
  final AddTaskPlanRepositories addTaskPlanRepositories;
  final UserLoginRepositories userLoginRepositories;
  final TaskPlanEntity model;

  ChangePlanBloc({
    @required this.repositories,
    @required this.userLoginRepositories,
    @required this.addTaskPlanRepositories,
    @required this.model,
  });

  @override
  ChangePlanState get initialState => LoadingChangePlanState();

  @override
  Stream<ChangePlanState> mapEventToState(
    ChangePlanEvent event,
  ) async* {
    if (event is InitPageEvent) {
      yield* _mapInitToState(event);
    }
    if (event is SubmitChangeEvent) {
      yield* _mapSubmitToState(event);
    }
  }

  Stream<ChangePlanState> _mapInitToState(InitPageEvent event) async* {
    try {
      List<PersonnelMessage> persons =
          await addTaskPlanRepositories.getPersonnelMessage();
      List<TaskCycleModel> cycles = addTaskPlanRepositories.getTaskCycleModel();
      List<InspectionSystem> systems =
          await addTaskPlanRepositories.getSystem();
      yield LoadedChangePlanState.init(
        model: model,
        people: persons,
        currentBuilding: userLoginRepositories.currentBuild,
        cycles: cycles,
        systems: systems,
      );
    } catch (e) {
      yield LoadErrorChangePlanState();
      rethrow;
    }
  }

  Stream<ChangePlanState> _mapSubmitToState(SubmitChangeEvent event) async* {
    yield (state as LoadedChangePlanState).submit();
    try {
      await repositories.changePlan(event.model);
      yield (state as LoadedChangePlanState).success();
    } catch (e) {
      yield (state as LoadedChangePlanState).fault();
      rethrow;
    }
  }
}
