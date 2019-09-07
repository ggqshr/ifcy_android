import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceMessageState extends Equatable {
  DeviceMessageState([List props = const <dynamic>[]]) : super(props);
}

class LoadingDeviceMessageState extends DeviceMessageState {}

class LoadedDeviceMessageState extends DeviceMessageState {
  final PageDataModel faultDeviceList;
  final PageDataModel runningDeviceList;
  final bool faultListReachMax;
  final bool runningListReachMax;

  LoadedDeviceMessageState(
      {this.faultDeviceList,
      this.runningDeviceList,
      this.faultListReachMax,
      this.runningListReachMax})
      : super([
          faultDeviceList,
          runningDeviceList,
          faultListReachMax,
          runningListReachMax,
        ]);

  LoadedDeviceMessageState copy(
      {faultDeviceList,
      runningDeviceList,
      faultListReachMax,
      runningListReachMax}) {
    return LoadedDeviceMessageState(
      faultDeviceList: faultDeviceList ?? this.faultDeviceList,
      runningDeviceList: runningDeviceList ?? this.runningDeviceList,
      faultListReachMax: faultListReachMax ?? this.faultListReachMax,
      runningListReachMax: runningListReachMax ?? this.runningListReachMax,
    );
  }
}

class LoadErrorDeviceMessageState extends DeviceMessageState {}
