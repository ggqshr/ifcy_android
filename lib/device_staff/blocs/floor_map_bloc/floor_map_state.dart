import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FloorMapState extends Equatable {
  FloorMapState([List props = const <dynamic>[]]) : super(props);
}

class LoadingFloorMapState extends FloorMapState {}

class LoadedFloorMapState extends FloorMapState {
  final List<FloorEntity> floors;
  final FloorEntity currentFloor;
  final List<InspectionDeviceModel> devices;
  final bool isLoading;

  LoadedFloorMapState({this.floors, this.currentFloor, this.devices,this.isLoading})
      : super([floors, currentFloor, devices,isLoading]);

  LoadedFloorMapState copyWith({
    List<FloorEntity> floors,
    FloorEntity currentFloor,
    List<InspectionDeviceModel> devices,
    bool isLoading,
  }) {
    return new LoadedFloorMapState(
      floors: floors ?? this.floors,
      currentFloor: currentFloor ?? this.currentFloor,
      devices: devices ?? this.devices,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}

class LoadErrorFloorMapState extends FloorMapState {}
