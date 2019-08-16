//线上故障设备实体类
class DeviceOnlineFaultModel {
  String deviceName;
  String deviceLoction;
  String deviceType;
  String deviceFalutFirstAlarmTime;
  String deviceFalutSecondAlarmTime;
  String faultConfirm;
  String faultConfirmPerson;
  String faultConfirmTime;
  String falutReasonDecription;
  String falutDevicePhoto;

  DeviceOnlineFaultModel({
    this.deviceName,
    this.deviceLoction,
    this.deviceType,
    this.deviceFalutFirstAlarmTime,
    this.deviceFalutSecondAlarmTime,
    this.faultConfirm,
    this.faultConfirmPerson,
    this.faultConfirmTime,
    this.falutReasonDecription,
    this.falutDevicePhoto
  });
}

//线下故障设备实体类
class DeviceOfflineFaultModel {
  String deviceName;
  String deviceLoction;
  String deviceType;
  String faultFindPerson;
  String faultReportTime;
  String falutReasonDecription;
  String falutDevicePhoto;

  DeviceOfflineFaultModel({
    this.deviceName,
    this.deviceLoction,
    this.deviceType,
    this.faultFindPerson,
    this.faultReportTime,
    this.falutReasonDecription,
    this.falutDevicePhoto
  });
}

class FaultDeviceDeclare {
  String deviceName;
  String deviceType;
  String deviceLoction;
  String falutReasonDecription;
  String falutDevicePhoto;
  String remarks;

  FaultDeviceDeclare({
    this.deviceName,
    this.deviceType,
    this.deviceLoction,
    this.falutReasonDecription,
    this.falutDevicePhoto,
    this.remarks
  });


}

//故障设备申报反馈实体类
class FaultDeviceDeclareFeedback {
  String number;//申报编号
  String feedbackContent;
  String feedbackExplanation;
  String processor;
  String time;

  FaultDeviceDeclareFeedback({this.feedbackContent,
    this.feedbackExplanation,
    this.processor,
    this.time});
}

//设备故障视图模型
abstract class FaultViewModel<T>{
  List<T> onlineDeviceFaultSured;
  List<T> onlineDeviceFaultUnSured;
  List<T> offlineDeviceFault;

  Function onRefreshCall;

  FaultViewModel({
    this.onlineDeviceFaultSured,
    this.onlineDeviceFaultUnSured,
    this.offlineDeviceFault,
    this.onRefreshCall,
});

}



