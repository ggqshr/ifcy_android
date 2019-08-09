import 'dart:math';
import 'model.dart';

class OnlineDeviceFaultUnsuredMessage extends FaultInfo {
  OnlineDeviceFaultUnsuredMessage(
    id,
    deviceName,
    deviceType,
    deviceLocation,
    alarmTimeFirst,
    alarmTimeLast,
    excutor,
  ) : super(
          id: id,
          deviceName: deviceName,
          deviceType: deviceType,
          deviceLocation: deviceLocation,
          alarmTimeFirst: alarmTimeFirst,
          alarmTimeLast: alarmTimeLast,
          excutor: excutor,
        );

  OnlineDeviceFaultUnsuredMessage.generate(id)
      : super(
          id: id,
          deviceName: "设备名称$id",
          deviceType: "设备类型$id",
          deviceLocation: "设备位置$id",
          alarmTimeFirst: '$id${DateTime.now()}',
          alarmTimeLast: "$id${DateTime.now()}",
        );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString()) +
        '{alarmTimeFirst: $alarmTimeFirst, alarmTimeLast: $alarmTimeLast}';
  }
}
