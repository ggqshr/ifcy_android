import 'package:equatable/equatable.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlanListState extends Equatable{
  PlanListState([List props = const <dynamic>[]]) : super(props);
}

class InitialPlanListState extends PlanListState {}

//加载完数据，进行渲染
class FetchedPlanListState extends PlanListState {
  final PlanTaskListPageModel model;
  final bool isReachMax;

  FetchedPlanListState({this.model, this.isReachMax=false}):super([model,isReachMax]);

  FetchedPlanListState copyWith({isReachMax, mm}) {
    return FetchedPlanListState(
      model: mm ?? this.model,
      isReachMax: isReachMax ?? this.isReachMax,
    );
  }
}

//加载过程中出现问题
class FetchErrorPlanListState extends PlanListState {}
