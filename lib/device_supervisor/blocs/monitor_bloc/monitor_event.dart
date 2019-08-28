import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MonitorEvent extends Equatable {
  MonitorEvent([List props = const <dynamic>[]]) : super(props);
}

///拉取监控页的数据
class FetchMonitorDataEvent extends MonitorEvent {}

///更新监控页的数据
class UpdateMonitorDataEvent extends MonitorEvent {}
