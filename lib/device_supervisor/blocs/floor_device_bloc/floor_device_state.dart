import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FloorDeviceState extends Equatable {
  FloorDeviceState([List props = const <dynamic>[]]) : super(props);
}

class LoadingFloorDeviceState extends FloorDeviceState {}

class LoadedFloorDeviceState extends FloorDeviceState {
  final FloorEntity currentFloor;
  final FloorDeviceModel device;
  final bool isLoading;

  LoadedFloorDeviceState({this.currentFloor, this.device, this.isLoading})
      : super([currentFloor, device, isLoading]);

  LoadedFloorDeviceState copyWith({
    FloorEntity currentFloor,
    List<InspectionDeviceModel> device,
    bool isLoading,
  }) {
    return new LoadedFloorDeviceState(
      currentFloor: currentFloor ?? this.currentFloor,
      device: device ?? this.device,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'LoadedFloorDeviceState{currentFloor: $currentFloor, device: $device, isLoading: $isLoading}';
  }

}

class LoadErrorFloorDeviceState extends FloorDeviceState {}
