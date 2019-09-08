///@author lc
///@description: 设备故障申报数据模型
///@date :2019/8/19 9:42
///
part of 'building_owner_model.dart';

class DeviceFaultDeclareModel{
   List<ProcessedDeviceFaultMessage> processedDeviceFaultList;//已处理的设备故障申报消息

   Function onRefreshCall;

   DeviceFaultDeclareModel({this.processedDeviceFaultList, this.onRefreshCall});
}