import 'dart:math';
import 'model.dart';

class OnlineDeviceFaultUnsuredMessage extends FaultInfo{
  String alarmTimeFirst;//首次报警时间
  String alarmTimeLast;//最后一次报警时间
  OnlineDeviceFaultUnsuredMessage(
      id,
      deviceName,
      deviceType,
      deviceLocation,
      this.alarmTimeFirst,
      this.alarmTimeLast,
      ):super(
    id:id,
    deviceName:deviceName,
    deviceType:deviceType,
    deviceLocation:deviceLocation,
  );

  OnlineDeviceFaultUnsuredMessage.generate(id)
      :alarmTimeFirst="$id${DateTime.now()}",
        alarmTimeLast="$id${DateTime.now()}",
        super(
        id: id,
        deviceName: "设备名称$id",
        deviceType: "设备类型$id",
        deviceLocation: "设备位置$id",
      );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString())+ '{alarmTimeFirst: $alarmTimeFirst, alarmTimeLast: $alarmTimeLast}';
  }


}

