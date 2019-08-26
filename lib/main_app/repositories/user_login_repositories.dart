import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/auth.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/main_app/model/AppState.dart';

///@author ggq
///@description:
///@date :2019/8/25 18:35

class UserLoginDataProvider {
  Future<UserEntity> login(String userName, String passWord) async {
    Response res = await DioUtils.getInstance().login(userName, passWord);
    var model = UserEntity.fromJson(res.data['data']);
    await Auth.getInstance().save(userName, passWord);
    return model;
  }

  Future<Build> getCurrentBuild() async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/building");
    return Build.fromJson(res.data['data']);
  }
}

class UserLoginRepositories {
  final bool alwaysLogin;
  final UserLoginDataProvider userLoginDataProvider;
  UserEntity _userEntity;
  Build _currentBuild;

  UserEntity get getUser => _userEntity;

  Build get currentBuild => _currentBuild;

  UserLoginRepositories({
    this.alwaysLogin = false,
  }) : userLoginDataProvider = UserLoginDataProvider();

  Future<void> login(String userName, String passWord) async {
    _userEntity = await userLoginDataProvider.login(userName, passWord);
    _currentBuild = await userLoginDataProvider.getCurrentBuild();
  }

  Future<void> loginWithLocal() async {
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    _userEntity = await userLoginDataProvider.login(userName, passWord);
    _currentBuild = await userLoginDataProvider.getCurrentBuild();
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
