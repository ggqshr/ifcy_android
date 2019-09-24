import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FloorDeviceEvent extends Equatable {
  FloorDeviceEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadFloorDeviceDetailEvent extends FloorDeviceEvent {}
