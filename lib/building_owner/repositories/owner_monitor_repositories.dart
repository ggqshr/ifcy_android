import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/repositories/monitor_repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

///@author ggq
///@description:
///@date :2019/9/8 10:16
class OwnerMonitorDataProvider {
  final Dio dio;
  SharedPreferences prefs;

  OwnerMonitorDataProvider([dio])
      : dio = dio ?? DioUtils.getInstance().getDio();

  Future<List<PersonnelMessage>> getAllUser() async {
    Response res = await dio.get("/sys-user/users");
    List<PersonnelMessage> userList = List.from(res.data['data']
        .map<PersonnelMessage>((item) => PersonnelMessage.fromJson(item)));
    return userList;
  }

  Future<int> getFireNum() async {
    Response res = await dio.get("/aggregation/current-fire-count");
    return int.parse(res.data['data']['fire_count']);
  }

  Future<void> _initSP() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
  }

  Future<void> setSPValue(String key, String value) async {
    await _initSP();
    prefs.setString(key, value);
  }

  Future<String> getSPValue(String key) async {
    await _initSP();
    return prefs.getString(key);
  }

  Future<bool> isExists(String key)async {
    await _initSP();
    return prefs.containsKey(key);
  }

  Future<int> getTrueFileNum() async {
    Response res = await dio.get("/aggregation/fire-records-count/TRULY_ALARM");
    return int.parse(res.data['data']['fire_records_count']);
  }
}

class OwnerMonitorRepositories {
  final OwnerMonitorDataProvider ownerMonitorDataProvider;
  final MonitorDataProvider provider;

  OwnerMonitorRepositories([provider, ownerProvider])
      : ownerMonitorDataProvider = ownerProvider ?? OwnerMonitorDataProvider(),
        provider = provider ?? MonitorDataProvider();

  Future<List<PersonnelMessage>> getUserList() async {
    return await ownerMonitorDataProvider.getAllUser();
  }

  Future<int> getDeviceFaultNum() async {
    return await provider.getDeviceFaultNum();
  }

  Future<int> getFireNum() async {
    return await ownerMonitorDataProvider.getFireNum();
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

  Future<int> getTrueFireNum() async {
    return await ownerMonitorDataProvider.getTrueFileNum();
  }
}
