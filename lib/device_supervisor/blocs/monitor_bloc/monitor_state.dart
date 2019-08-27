import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MonitorState extends Equatable {
  MonitorState([List props = const <dynamic>[]]) : super(props);
}

class InitialMonitorState extends MonitorState {}
