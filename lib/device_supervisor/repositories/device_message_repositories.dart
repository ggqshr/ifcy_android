import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';

///@author ggq
///@description:
///@date :2019/9/7 10:11
class DeviceMessageDataProvider {
  final Dio _dio;

  DeviceMessageDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future<PageDataModel> getFaultDevice({int listRows = 1, int page = 1}) async {
    Response res = await _dio.get("/device", queryParameters: {
      "page": page,
      "list_rows": listRows,
      "deviceStatus": "FAULT,DEFECT"
    });
    PageDataModel model = PageDataModel.fromJson(res.data['data']);
    model.dataList = model.dataList
        .map<DeviceMessage>((item) => DeviceMessage.fromJson(item))
        .toList();
    return model;
  }

  Future<PageDataModel> getRunningDevices(
      {int listRows = 1, int page = 1}) async {
    Response res = await _dio.get("/device", queryParameters: {
      "page": page,
      "list_rows": listRows,
      "deviceStatus": "RUNNING"
    });
    PageDataModel model = PageDataModel.fromJson(res.data['data']);
    model.dataList = model.dataList
        .map<DeviceMessage>((item) => DeviceMessage.fromJson(item))
        .toList();
    return model;
  }
}

class DeviceMessageRepositories {
  final DeviceMessageDataProvider _provider;

  DeviceMessageRepositories([provider])
      : _provider = provider ?? DeviceMessageDataProvider();

  Future<PageDataModel> getFaultDeviceFirstPage() async {
    return await _provider.getFaultDevice()
      ..currentPage = 1;
  }

  Future<PageDataModel> getFaultDeviceNextPage(int page) async {
    return await _provider.getFaultDevice(page: page);
  }

  Future<PageDataModel> getRunningDeviceFirstPage() async {
    return await _provider.getRunningDevices()
      ..currentPage = 1;
  }

  Future<PageDataModel> getRunningDeviceNextPage(int page) async {
    return await _provider.getRunningDevices(page: page);
  }
}
