import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

import '../device_staff_blocs.dart';

@immutable
abstract class DeviceListFilterEvent extends Equatable {
  DeviceListFilterEvent([List props = const <dynamic>[]]) : super(props);
}

///根据过滤条件更新列表
class UpdateFilterDeviceList extends DeviceListFilterEvent {}

///更新楼层过滤信息
class UpdateFloorFilter extends DeviceListFilterEvent {
  final String floorFiler;

  UpdateFloorFilter(this.floorFiler) : super([floorFiler]);
}

///更新装填过滤信息
class UpdateStatusFilter extends DeviceListFilterEvent {
  final CheckStatusFilter statusFilter;

  UpdateStatusFilter(this.statusFilter) : super([statusFilter]);
}

///更新设备列表
class UpdateDeviceList extends DeviceListFilterEvent {
  ///设备列表
  final List<InspectionDeviceModel> models;

  UpdateDeviceList(this.models) : super([models]);

  @override
  String toString() {
    return 'UpdateDeviceList{models: $models}';
  }
}
