import 'package:dio/dio.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/auth.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/main_app/model/AppState.dart';

///@author ggq
///@description:
///@date :2019/8/25 18:35
class UserLoginRepositories {
  final bool alwaysLogin;

  UserLoginRepositories({this.alwaysLogin=false});

  Future<UserEntity> _login(String userName, String passWord) async {
    Response res = await DioUtils.getInstance().login(userName, passWord);
    var model = UserEntity.fromJson(res.data['data']);
    await Auth.getInstance().save(userName, passWord);
    return model;
  }

  Future<UserEntity> login(String userName, String passWord) async {
    return await _login(userName, passWord);
  }

  Future<UserEntity> loginWithLocal() async {
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    return await _login(userName, passWord);
  }

  Future<bool> isLoginIn() async {
    if (alwaysLogin) {
      return false;
    }
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    if (userName != null && passWord != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    await Auth.getInstance().reset();
  }
}
