import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OwnerMonitorEvent extends Equatable {
  OwnerMonitorEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchOwnerMonitorDataEvent extends OwnerMonitorEvent {}

enum BlockTimeType {
  threeday, //三天
  oneday, //一天
  half, //半天
}

const Map<int, Duration> mapBlockTypeToDuration = {
  0: Duration(days: 3),
  1: Duration(days: 1),
  2: Duration(hours: 12),
};

class UpdateOwnerMonitorDataEvent extends OwnerMonitorEvent {
  final String deviceCode;
  final int blockOutTime;

  UpdateOwnerMonitorDataEvent(this.deviceCode, BlockTimeType blockType)
      : this.blockOutTime = DateTime.now()
            .add(mapBlockTypeToDuration[blockType.index])
            .millisecondsSinceEpoch;
}
