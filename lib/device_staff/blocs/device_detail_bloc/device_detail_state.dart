import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceDetailState extends Equatable {
  DeviceDetailState([List props = const <dynamic>[]]) : super(props);
}

class LoadingDetail extends DeviceDetailState {}

class LoadedDetail extends DeviceDetailState {
  final InspectionDeviceModel model;
  final List<FloorEntity> floorList;

  LoadedDetail({this.model,this.floorList}) : super([model,floorList]);

  @override
  String toString() {
    return 'LoadedDetail{model: $model, floorList: $floorList}';
  }

}

class LoadErrorDetail extends DeviceDetailState {}
