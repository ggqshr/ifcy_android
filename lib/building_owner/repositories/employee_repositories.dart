import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';

///@author ggq
///@description:
///@date :2019/9/8 11:26
class EmployeeDataProvider {
  final Dio dio;

  EmployeeDataProvider([dio]) : dio = dio ?? DioUtils.getInstance().getDio();

  Future<List<PersonnelMessage>> getAllUser() async {
    Response res = await dio.get("/sys-user/users");
    List<PersonnelMessage> userList = List.from(res.data['data']
        .map<PersonnelMessage>((item) => PersonnelMessage.fromJson(item)));
    return userList;
  }
}

class EmployeeRepositories {
  final EmployeeDataProvider provider;

  EmployeeRepositories([provider])
      : provider = provider ?? EmployeeDataProvider();

  Future<List<PersonnelMessage>> getAllUser() async {
    return await provider.getAllUser();
  }
}
