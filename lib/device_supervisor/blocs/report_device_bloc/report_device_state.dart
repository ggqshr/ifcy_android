import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportDeviceState extends Equatable {
  ReportDeviceState([List props = const <dynamic>[]]) : super(props);
}

class LoadingReportDevicesState extends ReportDeviceState {}

class LoadedReportDevicesState extends ReportDeviceState {
  final List<DeviceMessage> devicesToShow;
  final List<String> devicesToReport;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFault;

  LoadedReportDevicesState({
    @required this.devicesToShow,
    @required this.devicesToReport,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFault,
  }) : super([
          devicesToShow,
          devicesToReport,
          isSubmitting,
          isSuccess,
          isFault,
        ]);

  LoadedReportDevicesState success() {
    return LoadedReportDevicesState(
      devicesToShow: this.devicesToShow,
      devicesToReport: this.devicesToReport,
      isSubmitting: false,
      isSuccess: true,
      isFault: false,
    );
  }

  LoadedReportDevicesState fault() {
    return LoadedReportDevicesState(
      devicesToShow: this.devicesToShow,
      devicesToReport: this.devicesToReport,
      isSubmitting: false,
      isSuccess: false,
      isFault: true,
    );
  }

  LoadedReportDevicesState submitting() {
    return LoadedReportDevicesState(
      devicesToShow: this.devicesToShow,
      devicesToReport: this.devicesToReport,
      isSubmitting: true,
      isSuccess: false,
      isFault: false,
    );
  }

  LoadedReportDevicesState copyWith({
    List<DeviceMessage> devicesToShow,
    List<String> devicesToReport,
    bool isSubmitting,
    bool isSuccess,
    bool isFault,
  }) {
    return LoadedReportDevicesState(
      devicesToShow: devicesToShow ?? this.devicesToShow,
      devicesToReport: devicesToReport ?? this.devicesToReport,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFault: isFault ?? this.isFault,
    );
  }
}

class LoadErrorReportDevicesState extends ReportDeviceState {}
