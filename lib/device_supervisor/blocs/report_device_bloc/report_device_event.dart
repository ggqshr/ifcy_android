import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportDeviceEvent extends Equatable {
  ReportDeviceEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchReportDevice extends ReportDeviceEvent {}

class AddToReportList extends ReportDeviceEvent {
  final String code;

  AddToReportList(this.code) : super([code]);
}

class RemoveFromReportList extends ReportDeviceEvent {
  final String code;

  RemoveFromReportList(this.code) : super([code]);
}

class ReportToServer extends ReportDeviceEvent {}
