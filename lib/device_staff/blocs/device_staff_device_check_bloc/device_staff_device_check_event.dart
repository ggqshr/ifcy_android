import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceStaffDeviceCheckEvent extends Equatable {
  DeviceStaffDeviceCheckEvent([List props = const <dynamic>[]]) : super(props);
}

///加载数据
class LoadDevice extends DeviceStaffDeviceCheckEvent {
  final List<InspectionDeviceModel> models;

  LoadDevice(this.models) : super([models]);
}

///更新某一设备的状态
class UpdateDevice extends DeviceStaffDeviceCheckEvent {
  final InspectionDeviceModel model;

  UpdateDevice(this.model) : super([model]);

  @override
  String toString() {
    return 'UpdateDevice{model: $model}';
  }

}

///设备列表更新
class DeviceUpdate extends DeviceStaffDeviceCheckEvent {
  final List<InspectionDeviceModel> models;

  DeviceUpdate(this.models) : super([models]);

  @override
  String toString() {
    return 'DeviceUpdate{models: $models}';
  }

}
