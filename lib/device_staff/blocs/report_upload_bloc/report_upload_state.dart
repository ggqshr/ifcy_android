import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportUploadState extends Equatable {
  ReportUploadState([List props = const <dynamic>[]]) : super(props);
}

class InitialReportUploadState extends ReportUploadState {}

class ReportDeviceProblemState extends ReportUploadState {
  final List<String> devicesToReport;
  final List<InspectionDeviceModel> models;
  final bool isSuccess;
  final bool isFault;
  final bool isUploading;
  ReportDeviceProblemState(
      {this.devicesToReport,this.models, this.isSuccess=false, this.isFault=false, this.isUploading=false})
      : super([
  models,
  devicesToReport,
  isUploading,
  isSuccess,
  isFault,
  ]);
  ReportDeviceProblemState uploading() {
    return ReportDeviceProblemState(
      devicesToReport: this.devicesToReport,
      isFault: false,
      isSuccess: false,
      isUploading: true,
      models: this.models,
    );
  }
  ReportDeviceProblemState success() {
    return ReportDeviceProblemState(
      devicesToReport: this.devicesToReport,
      isFault: false,
      isSuccess: true,
      isUploading: false,
      models: this.models,
    );
  }
  ReportDeviceProblemState fault() {
    return ReportDeviceProblemState(
      devicesToReport: this.devicesToReport,
      isFault: true,
      isSuccess: false,
      isUploading: false,
      models: this.models,
    );
  }

  @override
  String toString() {
    return 'ReportDeviceProblemState{deviceToReport: $devicesToReport,models: $models, isSuccess: $isSuccess, isFault: $isFault, isUploading: $isUploading}';
  }

  ReportDeviceProblemState copyWith({
    List<String> devicesToReport,
    List<InspectionDeviceModel> models,
    bool isSubmitting,
    bool isSuccess,
    bool isFault,
  }) {
    return ReportDeviceProblemState(
      devicesToReport: devicesToReport ?? this.devicesToReport,
      models: models ?? this.models,
      isUploading: isSubmitting ?? this.isUploading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFault: isFault ?? this.isFault,
    );
  }

}

