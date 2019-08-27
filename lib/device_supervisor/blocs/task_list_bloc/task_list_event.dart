import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TaskListEvent extends Equatable {
  TaskListEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchTask extends TaskListEvent {}

class RefreshTask extends TaskListEvent {}