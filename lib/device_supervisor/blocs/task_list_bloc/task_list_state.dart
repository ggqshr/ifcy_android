import 'package:equatable/equatable.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TaskListState extends Equatable {
  TaskListState([List props = const <dynamic>[]]) : super(props);
}

class InitialTaskListState extends TaskListState {}

//加载完数据，进行渲染
class FetchedTaskListState extends TaskListState {
  final PlanTaskListPageModel model;
  final bool isReachMax;

  FetchedTaskListState({this.model, this.isReachMax=false}):super([model,isReachMax]);

  FetchedTaskListState copyWith({isReachMax, mm}) {
    return FetchedTaskListState(
      model: mm ?? this.model,
      isReachMax: isReachMax ?? this.isReachMax,
    );
  }
}

//加载过程中出现问题
class FetchErrorTaskListState extends TaskListState {}