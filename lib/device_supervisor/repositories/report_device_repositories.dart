import 'dart:convert';

///@author ggq
///@description:申报设备保修的repositories
///@date :2019/9/7 14:12
import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/repositories/device_message_repositories.dart';

class ReportDeviceDataProvider {
  final Dio _dio;

  ReportDeviceDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future reportToServer(
      List<String> devices, String title, String content) async {
    Map dataMap = {
      "comment": content,
      "title": title,
      "declaration_devices": devices.map((item) => {"code": item}).toList(),
    };
    Response res = await _dio.post(
      "/declare",
      data: jsonEncode(dataMap),
    );
  }

  Future<List<DeviceMessage>> getReportDeviceList() async {
    Response res = await _dio.get("/declare/devices");
    return List.from(res.data['data']
        .map<DeviceMessage>((item) => DeviceMessage.fromJson(item)));
  }

  Future<PageDataModel> getDedeclareList(
      {int listRow = 10, int page = 1}) async {
    Response res = await _dio
        .get("/declare", queryParameters: {"page": page, "list_rows": listRow});
    PageDataModel model = PageDataModel.fromJson(res.data['data']);
    model.dataList = model.dataList
        .map<DeclareMessage>((item) => DeclareMessage.fromJson(item))
        .toList();
    return model;
  }
}

class ReportDeviceRepositories {
  final ReportDeviceDataProvider provider;

  ReportDeviceRepositories([provider])
      : provider = provider ?? ReportDeviceDataProvider();

  Future reportToServer(
      List<String> devices, String title, String content) async {
    await provider.reportToServer(devices, title, content);
  }

  Future<List<DeviceMessage>> getDeviceList() async {
    return provider.getReportDeviceList();
  }

  Future<PageDataModel> getDeclareFirstPage() async {
    return await provider.getDedeclareList()
      ..currentPage = 1;
  }

  Future<PageDataModel> getDeclareNextPage(int page) async {
    return await provider.getDedeclareList(page: page);
  }
}
