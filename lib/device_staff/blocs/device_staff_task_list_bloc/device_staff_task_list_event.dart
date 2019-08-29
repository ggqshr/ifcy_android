import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceStaffTaskListEvent extends Equatable {
  DeviceStaffTaskListEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchAll extends DeviceStaffTaskListEvent {}

class FetchComplete extends DeviceStaffTaskListEvent {}

class FetchUnComplete extends DeviceStaffTaskListEvent {}

class RefreshComplete extends DeviceStaffTaskListEvent {}

class RefreshUnComplete extends DeviceStaffTaskListEvent {}
