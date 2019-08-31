import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceStaffDeviceCheckState extends Equatable {
  DeviceStaffDeviceCheckState([List props = const <dynamic>[]]) : super(props);
}

class DeviceListLoading extends DeviceStaffDeviceCheckState {}

class DeviceListLoaded extends DeviceStaffDeviceCheckState {
  final List<InspectionDeviceModel> models;
  final List<FloorEntity> floorList;

  DeviceListLoaded(this.models,this.floorList) : super([models,floorList]);

  @override
  String toString() {
    return 'DeviceListLoaded{models: $models, floorList: $floorList}';
  }

}

class DeviceListNotLoad extends DeviceStaffDeviceCheckState {}
