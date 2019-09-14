import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/utils.dart';

class CheckDeclareDataProvider {
  final Dio _dio;

  CheckDeclareDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future checkDeclare(String id) async {
    //todo 需要分为两种确认状态，一种同意，一种不同意
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

  Future checkUnPassDeclare(String id) async {
    await provider.checkDeclare(id);
  }
}
