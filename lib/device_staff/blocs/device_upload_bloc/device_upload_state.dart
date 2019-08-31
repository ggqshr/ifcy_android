import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceUploadState extends Equatable {
  DeviceUploadState([List props = const <dynamic>[]]) : super(props);
}

class InitialDeviceUploadState extends DeviceUploadState {}

class LoadedUploadDevice extends DeviceUploadState {
  final List<InspectionDeviceModel> models;
  final bool isSuccess;
  final bool isFault;
  final bool isUploading;
  LoadedUploadDevice(
      {this.models, this.isSuccess=false, this.isFault=false, this.isUploading=false})
      : super([models, isSuccess, isFault, isUploading]);
  LoadedUploadDevice uploading() {
    return LoadedUploadDevice(
      isFault: false,
      isSuccess: false,
      isUploading: true,
      models: this.models,
    );
  }
  LoadedUploadDevice success() {
    return LoadedUploadDevice(
      isFault: false,
      isSuccess: true,
      isUploading: false,
      models: this.models,
    );
  }
  LoadedUploadDevice fault() {
    return LoadedUploadDevice(
      isFault: false,
      isSuccess: false,
      isUploading: false,
      models: this.models,
    );
  }
}
