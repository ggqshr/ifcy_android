import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportUploadEvent extends Equatable {
  ReportUploadEvent([List props = const <dynamic>[]]) : super(props);
}

class ReportDeviceProblemEvent extends ReportUploadEvent {
  final List<InspectionDeviceModel> models;

  ReportDeviceProblemEvent(this.models) : super([models]);

  @override
  String toString() {
    return 'ReportDeviceProblemEvent{models: $models}';
  }

}

class GetReportDevice extends ReportUploadEvent{
  final List<InspectionDeviceModel> models;
  GetReportDevice(this.models):super([models]);
}

///上传到服务器
class ReportToServer extends ReportUploadEvent {}

class AddToReport extends ReportUploadEvent {
  final String code;

  AddToReport(this.code) : super([code]);
}

class RemoveFromReport extends ReportUploadEvent {
  final String code;

  RemoveFromReport(this.code) : super([code]);
}


