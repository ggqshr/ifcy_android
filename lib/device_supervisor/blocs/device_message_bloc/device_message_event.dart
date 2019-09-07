import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceMessageEvent extends Equatable {
  DeviceMessageEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchAllDevices extends DeviceMessageEvent {}

class FetchFaultDevices extends DeviceMessageEvent {}

class FetchRunningDevices extends DeviceMessageEvent {}

class RefreshFaultDevices extends DeviceMessageEvent {}

class RefreshRunningDevices extends DeviceMessageEvent {}
