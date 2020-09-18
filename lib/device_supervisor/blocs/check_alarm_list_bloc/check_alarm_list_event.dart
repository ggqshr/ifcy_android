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

///根据日期筛选火警信息
class UpdateAlarmByDate extends CheckAlarmListEvent {
  final DateTime findingDate;

  UpdateAlarmByDate(this.findingDate) : super([findingDate]);

  @override
  String toString() {
    return 'UpdateFindingDateFilter{findingDate: $findingDate}';
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


