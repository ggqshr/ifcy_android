import 'dart:math';
import 'model.dart';

///已确定的线上设备故障消息
class OnlineDeviceFaultSuredMessage extends FaultInfo {
  String confirmResult; //设备故障确定反馈
  String deviceFaultDes; //设备故障描述
  String faultDeclareTime; //设备故障时间
  String devicePhoto; //故障设备照片
  String remarks; //备注说明
  OnlineDeviceFaultSuredMessage(
    id,
    deviceName,
    deviceType,
    deviceLocation,
    alarmTimeFirst,
    alarmTimeLast,
    excutor,
    deviceFaultTime,
    this.confirmResult,
    this.deviceFaultDes,
    this.faultDeclareTime,
    this.devicePhoto,
    this.remarks,
  ) : super(
          id: id,
          deviceName: deviceName,
          deviceType: deviceType,
          deviceLocation: deviceLocation,
          alarmTimeFirst: alarmTimeFirst,
          alarmTimeLast: alarmTimeLast,
          deviceFaultTime:deviceFaultTime,
          excutor: excutor,
        );

  OnlineDeviceFaultSuredMessage.generate(id)
      : confirmResult = "确认故障/非故障$id",
        deviceFaultDes = "设备故障描述$id",
        faultDeclareTime = "$id${DateTime.now()}",
        devicePhoto = "故障设备照片$id",
        remarks = "备注$id",
        super(
            id: id,
            deviceName: "设备名称$id",
            deviceType: "设备类型$id",
            deviceLocation: "设备位置$id",
            alarmTimeFirst: '$id${DateTime.now()}',
            alarmTimeLast: "$id${DateTime.now()}",
            deviceFaultTime:"设备故障确认时间$id${DateTime.now()}",
            excutor: "故障确认者$id");

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString()) +
        '{confirmResult: $confirmResult, deviceFaultDes: $deviceFaultDes,faultDeclareTime: $faultDeclareTime, devicePhoto: $devicePhoto, remarks: $remarks}';
  }
}
