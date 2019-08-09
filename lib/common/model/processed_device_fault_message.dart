import 'dart:math';
import 'model.dart';


class ProcessedDeviceFaultMessage extends FaultInfo {
  String declareNum;//申报编号
  String deviceFaultDes; //设备故障描述
  String devicePhoto; //故障设备照片
  String remarks; //备注说明
  String declareTime;//申报时间
  String supervisor; //向上申报主管
  String declareFeedback; //申报反馈
  String feedbackTime; //反馈时间


  ProcessedDeviceFaultMessage(id,
      deviceName,
      deviceType,
      deviceLocation,
      excutor, //设备故障确认人
      deviceFaultTime,
      this.declareNum,
      this.deviceFaultDes,
      this.devicePhoto,
      this.remarks,
      this.declareTime,
      this.supervisor,
      this.declareFeedback,
      this.feedbackTime,) : super(
    id: id,
    deviceName: deviceName,
    deviceType: deviceType,
    deviceLocation: deviceLocation,
    deviceFaultTime: deviceFaultTime,
    excutor: excutor,
  );

  ProcessedDeviceFaultMessage.generate(id)
      : declareNum="申报编号$id",
        deviceFaultDes = "设备故障描述$id",
        devicePhoto = "故障设备照片$id",
        remarks = "备注$id",
        declareTime="${DateTime.now()}",
        supervisor = "主管$id",
        declareFeedback="同意/不同意更换设备$id",
        feedbackTime="${DateTime.now()}",
        super(
          id: id,
          deviceName: "设备名称$id",
          deviceType: "设备类型$id",
          deviceLocation: "设备位置$id",
          deviceFaultTime: "设备故障确认时间$id${DateTime.now()}",
          excutor: "故障确认者$id");

  @override
  String toString() {
    return super.toPrint(this.runtimeType.toString()) +
        '{declareNum:$declareNum,deviceFaultDes: $deviceFaultDes, devicePhoto: $devicePhoto, remarks: $remarks,declareTime:$declareTime, supervisor: $supervisor, declareFeedback: $declareFeedback, feedbackTine: $feedbackTime}';
  }
}