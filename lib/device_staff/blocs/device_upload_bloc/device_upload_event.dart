import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceUploadEvent extends Equatable {
  DeviceUploadEvent([List props = const <dynamic>[]]) : super(props);
}

class GetUploadData extends DeviceUploadEvent{
  final List<InspectionDeviceModel> models;
  GetUploadData(this.models):super([models]);
}

///上传到服务器
class UploadToServer extends DeviceUploadEvent {}
