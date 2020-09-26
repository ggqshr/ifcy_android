import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/plan_list_repositories.dart';

import 'bloc.dart';

class PlanListBloc extends Bloc<PlanListEvent, PlanListState> {
  final PlanListRepositories repositories;

  PlanListBloc(this.repositories);

  bool _hasReachMax(PlanListState state) =>
      state is FetchedPlanListState && state.isReachMax;

  @override
  PlanListState get initialState => InitialPlanListState();

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
  }

  @override
  Stream<PlanListState> mapEventToState(
    PlanListEvent event,
  ) async* {
    print("${event.runtimeType} $event");
    if (event is FetchPlan && !_hasReachMax(state)) {
      try {
        if (state is InitialPlanListState) {
          final PlanTaskListPageModel model = await repositories.getFirstPage();
          yield FetchedPlanListState(model: model);
          return;
        }
        if (state is FetchedPlanListState) {
          final PlanTaskListPageModel model = await repositories.getNextPage(
              (state as FetchedPlanListState).model.currentPageNum + 1);
          yield model.planLists.isEmpty
              ? (state as FetchedPlanListState)
                  .copyWith(isReachMax: true)
              : FetchedPlanListState(
                  isReachMax: false,
                  model: (state as FetchedPlanListState)
                      .model
                      .nextPage(model),
                );
        }
      } catch (e) {
        yield FetchErrorPlanListState();
        rethrow;
      }
    }
    if(event is RefreshPlan){
      final PlanTaskListPageModel model = await repositories.getFirstPage();
      yield FetchedPlanListState(model: model);
      return;
    }
  }
}
