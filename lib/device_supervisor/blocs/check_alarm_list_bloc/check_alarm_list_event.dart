import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckAlarmListEvent extends Equatable {
  CheckAlarmListEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchCheckedAlarmData extends CheckAlarmListEvent {
  final bool isFire;

  FetchCheckedAlarmData(this.isFire) : super([isFire]);

  @override
  String toString() {
    return 'FetchCheckedAlarmData{isFire: $isFire}';
  }
}

class RefreshCheckAlarmData extends CheckAlarmListEvent {
  final bool isFire;

  RefreshCheckAlarmData(this.isFire) : super([isFire]);

  @override
  String toString() {
    return 'RefreshCheckAlarmData{isFire: $isFire}';
  }
}

class RefreshTrueAlarmData extends CheckAlarmListEvent {}

class FetchTrueAlarmData extends CheckAlarmListEvent {}

///首次根据日期筛选火警信息
class FilterCheckAlarmData extends CheckAlarmListEvent {
  final DateTime findingDate;

  FilterCheckAlarmData(this.findingDate) : super([findingDate]);

  @override
  String toString() {
    return 'FilterCheckAlarmData{findingDate: $findingDate}';
  }
}

/// 将列表下拉到底，继续筛选火警信息
class ContinueFilterCheckAlarmData extends CheckAlarmListEvent {
  final DateTime findingDate;

  ContinueFilterCheckAlarmData(this.findingDate) : super([findingDate]);

  @override
  String toString() {
    return 'ContinueFilterCheckAlarmData{findingDate: $findingDate}';
  }
}

/// 在筛选情况下刷新界面
class RefreshFilterCheckAlarmData extends CheckAlarmListEvent {
  final DateTime findingDate;

  RefreshFilterCheckAlarmData(this.findingDate) : super([findingDate]);

  @override
  String toString() {
    return 'RefreshFilterCheckAlarmData{findingDate: $findingDate}';
  }
}

///显示用户选择好的筛选日期
class UpdateFindingDateFilter extends CheckAlarmListEvent {
  final DateTime findingDate;

  UpdateFindingDateFilter(this.findingDate) : super([findingDate]);

  @override
  String toString() {
    return 'UpdateFindingDateFilter{findingDate: $findingDate}';
  }
}

///重置筛选条件，同时重设页面state
class ResetCheckAlarmListState extends CheckAlarmListEvent {

  ResetCheckAlarmListState() : super([]);

  @override
  String toString() {
    return 'UpdateFindingDateFilter{}';
  }
}


