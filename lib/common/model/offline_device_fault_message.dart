import 'dart:math';
import 'model.dart';

///线下设备故障消息的数据model

class OfflineDeviceFaultMessage extends FaultInfo {
  String deviceFaultDes;//设备故障描述
  String deviceFaultExcutor;//检报人员
  String faultDeclareTime;//检报时间
  String  devicePhoto;//故障设备照片
  String remarks;//备注说明
  OfflineDeviceFaultMessage(
    id,
    deviceName,
    deviceType,
    deviceLocation,
  ) : super(
          id: id,
          deviceName: deviceName,
          deviceType: deviceType,
          deviceLocation: deviceLocation,
        ){
    this.deviceFaultDes=deviceFaultDes;
    this.deviceFaultExcutor=deviceFaultExcutor;
    this.faultDeclareTime=faultDeclareTime;
    this.devicePhoto=devicePhoto;
    this.remarks=remarks;
  }

  OfflineDeviceFaultMessage.generate(id):super(
    id: id,
    deviceName:"设备$id",
    deviceType: "设备类型$id",
    deviceLocation: "设备位置$id",
  ){
    deviceFaultDes:"设备故障描述$id";
    deviceFaultExcutor:"设备故障检报人员$id";
    faultDeclareTime:"设备故障检报时间$id";
    devicePhoto:"故障设备照片$id";
    remarks:"备注说明$id";
  }


  @override
  String toString() {
    super.toString();

    //return 'OfflineDeviceFaultMessage{deviceFaultDes: $deviceFaultDes, deviceFaultExcutor: $deviceFaultExcutor, faultDeclareTime: $faultDeclareTime, devicePhoto: $devicePhoto, remarks: $remarks}';
  }
}
