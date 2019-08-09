import 'dart:math';
import 'model.dart';

///线下设备故障消息的数据model

class OfflineDeviceFaultMessage extends FaultInfo{
  String deviceFaultDes; //设备故障描述
  String deviceFaultExcutor; //检报人员
  String devicePhoto; //故障设备照片
  String remarks; //备注说明
  OfflineDeviceFaultMessage(id,
      deviceName,
      deviceType,
      deviceLocation,
      deviceFaultTime,
      this.deviceFaultDes,
      this.deviceFaultExcutor,
      this.devicePhoto,
      this.remarks,) : super(
    id: id,
    deviceName: deviceName,
    deviceType: deviceType,
    deviceLocation: deviceLocation,
    deviceFaultTime:deviceFaultTime,
  );

  OfflineDeviceFaultMessage.generate(id,)
      :deviceFaultDes="设备故障描述$id",
        deviceFaultExcutor="设备故障发现者$id",
        devicePhoto="故障设备照片$id",
        remarks="备注$id",
        super(
        id: id,
        deviceName: "设备名称$id",
        deviceType: "设备类型$id",
        deviceLocation: "设备位置$id",
        deviceFaultTime:"设备故障时间${DateTime.now()}"
      );


  @override
  String toString() {
   return super.toPrint(this.runtimeType.toString()+"{deviceFaultDes:$deviceFaultDes,deviceFaultExcutor:$deviceFaultExcutor,devicePhoto:$devicePhoto,remarks:$remarks}");
    //return 'OfflineDeviceFaultMessage{deviceFaultDes: $deviceFaultDes, deviceFaultExcutor: $deviceFaultExcutor, faultDeclareTime: $faultDeclareTime, devicePhoto: $devicePhoto, remarks: $remarks}';
  }
}
