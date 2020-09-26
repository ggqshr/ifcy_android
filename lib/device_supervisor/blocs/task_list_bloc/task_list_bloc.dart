import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';

import './bloc.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskListRepositories repositories;

  TaskListBloc(this.repositories);

  bool _hasReachMax(TaskListState state) =>
      state is FetchedTaskListState && state.isReachMax;
  @override
  TaskListState get initialState => InitialTaskListState();

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is FetchTask && !_hasReachMax(state)) {
      try {
        if (state is InitialTaskListState) {
          final PlanTaskListPageModel model = await repositories.getFirstPage();
          yield FetchedTaskListState(model: model);
          return;
        }
        if (state is FetchedTaskListState) {
          final PlanTaskListPageModel model = await repositories.getNextPage(
              (state as FetchedTaskListState).model.currentPageNum + 1);
          yield model.planLists.isEmpty
              ? (state as FetchedTaskListState)
              .copyWith(isReachMax: true)
              : FetchedTaskListState(
            isReachMax: false,
            model: (state as FetchedTaskListState)
                .model
                .nextPage(model),
          );
          return;
        }
        if(event is RefreshTask){
          final PlanTaskListPageModel model = await repositories.getFirstPage();
          yield FetchedTaskListState(model: model);
        }
      } catch (e) {
        yield FetchErrorTaskListState();
        rethrow;
      }
    }
  }
}
