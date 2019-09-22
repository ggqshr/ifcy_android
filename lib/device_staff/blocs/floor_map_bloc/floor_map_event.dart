import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FloorMapEvent extends Equatable {
  FloorMapEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadFloorDetailEvent extends FloorMapEvent {}

class ChangeFloorEvent extends FloorMapEvent {
  final String floorId;

  ChangeFloorEvent(this.floorId) : super([floorId]);
}
