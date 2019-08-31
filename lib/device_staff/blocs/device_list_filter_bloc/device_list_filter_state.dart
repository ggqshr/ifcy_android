import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceListFilterState extends Equatable {
  DeviceListFilterState([List props = const <dynamic>[]]) : super(props);
}

class FilterDeviceListLoading extends DeviceListFilterState {}

enum CheckStatusFilter {
  all,
  checked,
  unchecked,
}

List<String> checkStatusFilterTypeString = ["全部", "完成", "未完成"];

class FilterDeviceListLoaded extends DeviceListFilterState {
  ///设备列表
  final List<InspectionDeviceModel> models;

  ///根据状态过滤的条件
  final CheckStatusFilter statusFilter;

  ///根据楼层过滤的条件
  final String floorFilter;

  FilterDeviceListLoaded({this.models, this.statusFilter, this.floorFilter})
      : super([models, statusFilter, floorFilter]);

  FilterDeviceListLoaded copy({models, statusFilter, floorFilter}) {
    return FilterDeviceListLoaded(
      models: models ?? this.models,
      statusFilter: statusFilter ?? this.statusFilter,
      floorFilter: floorFilter ?? this.floorFilter,
    );
  }

  @override
  String toString() {
    return 'FilterDeviceListLoaded{models: $models, statusFilter: $statusFilter, floorFilter: $floorFilter}';
  }
}
