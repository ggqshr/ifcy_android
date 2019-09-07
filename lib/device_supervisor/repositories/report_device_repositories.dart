import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/repositories/device_message_repositories.dart';

///@author ggq
///@description:
///@date :2019/9/7 14:12
class ReportDeviceDataProvider {
  final Dio _dio;

  ReportDeviceDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future reportToServer(List<String> devices) async {
    //todo 申报到服务器
  }

  Future<List<DeviceMessage>> getReportDeviceList() async {
    return [
      DeviceMessage(
        area: "nihao",
        category: "111",
        code: "11",
        floor: "11",
        id: "11",
        name: "111",
        online: true,
        position: "sss",
        status: "FAULT",
      )
    ];
  }
}

class ReportDeviceRepositories {
  final ReportDeviceDataProvider provider;

  ReportDeviceRepositories([provider])
      : provider = provider ?? ReportDeviceDataProvider();

  Future reportToServer(List<String> devices) async {
    await provider.reportToServer(devices);
  }

  Future<List<DeviceMessage>> getDeviceList() async {
    return provider.getReportDeviceList();
  }
}
