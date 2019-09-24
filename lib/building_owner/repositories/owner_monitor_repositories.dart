import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/repositories/monitor_repositories.dart';

///@author ggq
///@description:
///@date :2019/9/8 10:16
class OwnerMonitorDataProvider {
  final Dio dio;

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
