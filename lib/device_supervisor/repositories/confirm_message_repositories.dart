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

  Future confirmFireMessage(String eventId, String checkResult) async {
    await _dio.patch(
      "/warning-msg/$eventId/fire/determine",
      data: jsonEncode(
        {"check_fire_type": checkResult},
      ),
    );
  }

  Future confirmDeviceFaultMessage(String eventId, String checkResult) async {
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

  Future confirmFireFire(String eventId) async {
    await _provider.confirmFireMessage(eventId, "TRULY_ALARM");
  }

  Future confirmFireFault(String eventId) async {
    await _provider.confirmFireMessage(eventId, "FALSE_ALARM");
  }

  Future confirmDeviceProcessed(String eventId) async {
    await _provider.confirmDeviceFaultMessage(eventId, "PROCESSED");
  }

  Future confirmDeviceUnProcessed(String eventId) async {
    await _provider.confirmDeviceFaultMessage(eventId, "UNPROCESSED");
  }
}
