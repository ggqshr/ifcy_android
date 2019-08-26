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
  Stream<PlanListState> mapEventToState(
    PlanListEvent event,
  ) async* {
    print(event);
    if (event is Fetch && !_hasReachMax(currentState)) {
      try {
        if (currentState is InitialPlanListState) {
          final PlanListPageModel model = await repositories.getFirstPage();
          yield FetchedPlanListState(model: model);
          return;
        }
        if (currentState is FetchedPlanListState) {
          final PlanListPageModel model = await repositories.getNextPage(
              (currentState as FetchedPlanListState).model.currentPageNum + 1);
          yield model.planLists.isEmpty
              ? (currentState as FetchedPlanListState)
                  .copyWith(isReachMax: true)
              : FetchedPlanListState(
                  isReachMax: false,
                  model: (currentState as FetchedPlanListState)
                      .model
                      .nextPage(model),
                );
        }
      } catch (e) {
        yield FetchErrorPlanListState();
        rethrow;
      }
    }
    if(event is Refresh){
      final PlanListPageModel model = await repositories.getFirstPage();
      yield FetchedPlanListState(model: model);
      return;
    }
  }
}
