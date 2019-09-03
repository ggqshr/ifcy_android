import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';

///@author ggq
///@description:
///@date :2019/9/3 10:40
class CheckedAlarmDataProvider {
  final Dio _dio;

  CheckedAlarmDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future<PageDataModel> getFireCheckMessage(
      {int listRows = 1, int page = 1}) async {
    Response res = await _dio.get("/warning-msg/fire-records",
        queryParameters: {"page": page, "list_rows": listRows});
    PageDataModel model = PageDataModel.fromJson(res.data['data']);
    model.dataList = model.dataList
        .map<FireCheckAlarmMessage>(
            (item) => FireCheckAlarmMessage.fromJson(item))
        .toList();
    return model;
  }

  Future<PageDataModel> getDeviceCheckMessage(
      {int listRows = 1, int page = 1}) async {
    Response res = await _dio.get("/warning-msg/fault-records",
        queryParameters: {"page": page, "list_rows": listRows});
    PageDataModel model = PageDataModel.fromJson(res.data['data']);
    model.dataList = model.dataList
        .map<DeviceCheckedAlarmMessage>(
            (item) => DeviceCheckedAlarmMessage.fromJson(item))
        .toList();
    return model;
  }
}

class CheckAlarmRepositories {
  final CheckedAlarmDataProvider _provider;

  CheckAlarmRepositories([provider])
      : _provider = provider ?? CheckedAlarmDataProvider();

  Future<PageDataModel> getFireFirstPage() async {
    return await _provider.getFireCheckMessage()..currentPage=1;
  }

  Future<PageDataModel> getFireNextPage(int page) async {
    return await _provider.getFireCheckMessage(page: page);
  }

  Future<PageDataModel> getDeviceFirstPage() async {
    return await _provider.getDeviceCheckMessage()..currentPage=1;
  }

  Future<PageDataModel> getDeviceNextPage(int page) async {
    return await _provider.getDeviceCheckMessage(page: page);
  }
}
