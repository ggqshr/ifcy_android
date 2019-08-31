import 'package:equatable/equatable.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeviceDetailEvent extends Equatable {
  DeviceDetailEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadData extends DeviceDetailEvent {
  final InspectionDeviceModel model;

  LoadData(this.model) : super([model]);
}

class UpdateCheckResult extends DeviceDetailEvent {
  final CheckResult checkResult;

  UpdateCheckResult(this.checkResult) : super([checkResult]);
}

class UpdateComment extends DeviceDetailEvent {
  final String comment;

  UpdateComment(this.comment) : super([comment]);
}

class UpdateImages extends DeviceDetailEvent {
  final String imageAName;
  final int index;

  UpdateImages(this.imageAName, this.index) : super([imageAName, index]);

  @override
  String toString() {
    return 'UpdateImages{imageAName: $imageAName, index: $index}';
  }

}

class UpdateLocal extends DeviceDetailEvent {}
