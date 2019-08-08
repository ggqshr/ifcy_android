import 'dart:math';
import 'model.dart';

///已确定的线上设备故障消息
class OnlineDeviceFaultSuredMessage extends FaultInfo {
  String confirmResult; //设备故障确定反馈
  String deviceFaultDes; //设备故障原因描述
  String deviceFaultExcutor; //设备故障确定人员
  String faultDeclareTime; //处理时间
  String devicePhoto; //故障设备照片
  String remarks; //备注说明
  OnlineDeviceFaultSuredMessage(
    id,
    deviceName,
    deviceType,
    deviceLocation,
    this.confirmResult,
    this.deviceFaultDes,
    this.deviceFaultExcutor,
    this.faultDeclareTime,
    this.devicePhoto,
    this.remarks,
  ) : super(
          id: id,
          deviceName: deviceName,
          deviceType: deviceType,
          deviceLocation: deviceLocation,
        );

  OnlineDeviceFaultSuredMessage.generate(id)
      : confirmResult = "确认故障/非故障$id",
        deviceFaultDes = "设备故障描述$id",
        deviceFaultExcutor = "设备故障发现者$id",
        faultDeclareTime = "$id${DateTime.now()}",
        devicePhoto = "故障设备照片$id",
        remarks = "备注$id",
        super(
          id: id,
          deviceName: "设备名称$id",
          deviceType: "设备类型$id",
          deviceLocation: "设备位置$id",
        );

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString())+'{confirmResult: $confirmResult, deviceFaultDes: $deviceFaultDes, deviceFaultExcutor: $deviceFaultExcutor, faultDeclareTime: $faultDeclareTime, devicePhoto: $devicePhoto, remarks: $remarks}';
  }


}
