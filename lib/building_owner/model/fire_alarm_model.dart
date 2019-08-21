///@author lc
///@description: 火警警报记录数据模块
///@date :2019/8/20 14:45
part of 'building_owner_model.dart';
class FireAlarmModel{

  List<FireAlarmMessage> fireAlarmHistoryMessages;//已处理的设备故障申报消息
  Function onRefreshCall;

  FireAlarmModel({this.fireAlarmHistoryMessages, this.onRefreshCall});
}