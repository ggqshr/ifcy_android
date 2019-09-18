import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/utils.dart';

class CheckDeclareDataProvider {
  final Dio _dio;

  CheckDeclareDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future checkDeclare(String id) async {
    await _dio.patch("/declare/$id/check");
  }
}

class CheckDeclareRepositories {
  final CheckDeclareDataProvider provider;

  CheckDeclareRepositories([provider])
      : provider = provider ?? CheckDeclareDataProvider();

  Future checkPassDeclare(String id) async {
    await provider.checkDeclare(id);
  }
}
