///@author ggq
///@description: 确认和查看报警消息的repositories
///@date :2019/9/2 15:22

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/dio_util.dart';

class ConfirmMessageDataProvider {
  final Dio _dio;

  ConfirmMessageDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future confirmFireMessage(
      String eventId, String checkResult, String commentText) async {
    //todo 发送备注信息到服务器
    await _dio.patch(
      "/warning-msg/$eventId/fire/determine",
      data: jsonEncode(
        {"check_fire_type": checkResult},
      ),
    );
  }

  Future confirmDeviceFaultMessage(
      String eventId, String checkResult, String commentText) async {
    //todo 发送备注信息到服务器
    await _dio.patch(
      "/warning-msg/$eventId/fault/determine",
      data: jsonEncode(
        {"check_fault_type": checkResult},
      ),
    );
  }
}

class ConfirmMessageRepositories {
  final ConfirmMessageDataProvider _provider;

  ConfirmMessageRepositories([provider])
      : _provider = provider ?? ConfirmMessageDataProvider();

  Future confirmFireFire(String eventId, String commentText) async {
    await _provider.confirmFireMessage(eventId, "TRULY_ALARM", commentText);
  }

  Future confirmFireFault(String eventId, String commentText) async {
    await _provider.confirmFireMessage(eventId, "FALSE_ALARM", commentText);
  }

  Future confirmDeviceProcessed(String eventId, String commentText) async {
    await _provider.confirmDeviceFaultMessage(
        eventId, "PROCESSED", commentText);
  }

  Future confirmDeviceUnProcessed(String eventId, String commentText) async {
    await _provider.confirmDeviceFaultMessage(
        eventId, "UNPROCESSED", commentText);
  }
}
