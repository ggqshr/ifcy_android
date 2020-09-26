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
