import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifcy/building_owner/repositories/building_owner_repositories.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';

///@author ggq
///@description:
///@date :2019/8/28 15:49
class MonitorDataProvider {
  Dio _dio;

  MonitorDataProvider([dio]) : _dio = dio ?? DioUtils.getInstance().getDio();

  Future<int> getDeviceFaultNum() async {
    Response res = await _dio.get("/aggregation/fault-device-count");
    Map data = res.data['data'];
    return int.parse(data["fault_count"]);
  }

  Future<int> getTaskCompleteRate() async {
    Response res = await _dio.get("/aggregation/patrol-device-count");
    Map data = res.data['data'];
    int device_num = int.parse(data['device_num']);
    int checked_num = int.parse(data['checked_device_num']);
    if (device_num == 0) return 0;
    return (checked_num / device_num).round();
  }

  Future<List<FireAlarmMessage>> getFireAlarmMsg() async {
    Response res = await _dio.get("/warning-msg/messages/FIRE");
    return res.data['data']
        .map<FireAlarmMessage>((item) => FireAlarmMessage.fromJson(item))
        .toList();
  }

  Future<List<DeviceFaultAlarmMessage>> getDeviceFaultMsg() async {
    Response res = await _dio.get("/warning-msg/messages/FAULT");
    return res.data['data']
        .map<DeviceFaultAlarmMessage>(
            (item) => DeviceFaultAlarmMessage.fromJson(item))
        .toList();
  }

  Future<List<TaskInfoMessage>> getTaskInfoMsg() async {
    return [
      TaskInfoMessage(
          id: "1", title: "任务1", content: "任务", status: TaskStatus.completed),
      TaskInfoMessage(
          id: "2",
          title: "任务2",
          content: "任务2",
          status: TaskStatus.uncompleted),
    ];
  }
}

class MonitorRepositories {
  final OwnerMonitorDataProvider ownerMonitorDataProvider;
  final MonitorDataProvider provider;

  MonitorRepositories([data])
      : provider = data ?? MonitorDataProvider(),
        ownerMonitorDataProvider = OwnerMonitorDataProvider();

  Future<int> getDeviceFaultNum() async {
    return await provider.getDeviceFaultNum();
  }

  Future<int> getTaskCompleteRate() async {
    return await provider.getTaskCompleteRate();
  }

  Future<List<FireAlarmMessage>> getFireAlarmMsg(String userName) async {
    List<FireAlarmMessage> msgs = await provider.getFireAlarmMsg();
    if (!await ownerMonitorDataProvider.isExists(userName)) {
      //如果sp中没有该用户的对应信息，直接跳过
      return msgs;
    }
    Map thisMap =
    json.decode(await ownerMonitorDataProvider.getSPValue(userName));
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    List<FireAlarmMessage> filtedMsgs = msgs.where((item) {
      if (thisMap.containsKey(item.deviceCode)) {
        if (nowTimeStamp >= thisMap[item.deviceCode]) {
          thisMap.remove(item.deviceCode);
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    }).toList();
    ownerMonitorDataProvider.setSPValue(userName, json.encode(thisMap));
    return filtedMsgs;
  }

  Future<List<DeviceFaultAlarmMessage>> getDeviceFaultMsg() async {
    return await provider.getDeviceFaultMsg();
  }

  Future<List<TaskInfoMessage>> getTaskInfoMsg() async {
    return await provider.getTaskInfoMsg();
  }

  Future<void> setBlockDevice(
      String userName, String deviceCode, int expireTimeStamp) async {
    Map thisMap;
    if (await ownerMonitorDataProvider.isExists(userName)) {
      thisMap =
          json.decode(await ownerMonitorDataProvider.getSPValue(userName));
    } else {
      thisMap = Map<String, int>();
    }
    thisMap[deviceCode] = expireTimeStamp;
    ownerMonitorDataProvider.setSPValue(userName, json.encode(thisMap));
  }
}
