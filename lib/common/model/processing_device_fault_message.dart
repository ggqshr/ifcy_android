import 'dart:math';
import 'model.dart';


///处理中故障申报信息

class ProcessingDeviceFaultMessage extends FaultInfo {
  String declareNum;//申报编号
  String declareTime;//申报时间
  String deviceFaultDes; //设备故障描述
  String devicePhoto; //故障设备照片
  String remarks; //备注说明
  String supervisor; //向上申报主管
  ProcessingDeviceFaultMessage(
    id,
    deviceName,
    deviceType,
    deviceLocation,
    excutor, //设备故障确认人
    deviceFaultTime,
    this.declareNum,
    this.declareTime,
    this.deviceFaultDes,
    this.devicePhoto,
    this.remarks,
  ) : super(
          id: id,
          deviceName: deviceName,
          deviceType: deviceType,
          deviceLocation: deviceLocation,
          deviceFaultTime: deviceFaultTime,
          excutor: excutor,
        );

  ProcessingDeviceFaultMessage.generate(id)
      : deviceFaultDes = "设备故障描述$id",
        devicePhoto = "故障设备照片$id",
        remarks = "备注$id",
        supervisor = "主管$id",
        declareNum="申报编号$id",
        declareTime="申报时间${DateTime.now()}",
        super(
            id: id,
            deviceName: "设备名称$id",
            deviceType: "设备类型$id",
            deviceLocation: "设备位置$id",
            deviceFaultTime: "设备故障确认时间$id${DateTime.now()}",
            excutor: "故障确认者$id");

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString())+'{declareNum: $declareNum, declareTime: $declareTime, deviceFaultDes: $deviceFaultDes, devicePhoto: $devicePhoto, remarks: $remarks, supervisor: $supervisor}';
  }


}
