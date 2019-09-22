import 'package:dio/dio.dart';
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
    Map data =res.data['data'];
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
  final MonitorDataProvider provider;

  MonitorRepositories([data]) : provider = data ?? MonitorDataProvider();

  Future<int> getDeviceFaultNum() async {
    return await provider.getDeviceFaultNum();
  }

  Future<int> getTaskCompleteRate() async {
    return await provider.getTaskCompleteRate();
  }

  Future<List<FireAlarmMessage>> getFireAlarmMsg() async {
    return await provider.getFireAlarmMsg();
  }

  Future<List<DeviceFaultAlarmMessage>> getDeviceFaultMsg() async {
    return await provider.getDeviceFaultMsg();
  }

  Future<List<TaskInfoMessage>> getTaskInfoMsg() async {
    return await provider.getTaskInfoMsg();
  }
}
