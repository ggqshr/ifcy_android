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

  UserLoginDataProvider();

  Future<UserEntity> login(String userName, String passWord) async {
    Response res = await DioUtils.getInstance().login(userName, passWord);
    var model = UserEntity.fromJson(res.data['data']);
    await Auth.getInstance().save(userName, passWord);
    return model;
  }

  Future setUpJpush(UserEntity userEntity) async {
    String fireTag = "FIRE_${userEntity.buildingCode}";
    String alias = "USER_${userEntity.userName}";
    String faultTag = "FAULT_${userEntity.buildingCode}";
  }

  Future<Build> getCurrentBuild() async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/building");
    return Build.fromJson(res.data['data']);
  }

  Future<List<LoginUserInfo>> getSavedUserInfos() {
    return Auth.getInstance().getUserInfos();
  }

  Future writeSavedUserInfos(List<LoginUserInfo> infos) {
    Auth.getInstance().saveUserInfos(infos);
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

  Future<List<LoginUserInfo>> getLoginUserInfos() {
    return userLoginDataProvider.getSavedUserInfos();
  }

  Future<UserEntity> login(String userName, String passWord) async {
    return await _login(userName, passWord);
  }

  Future<UserEntity> loginWithLocal() async {
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    return await _login(userName, passWord);
  }

  Future<Build> getCurrentBuilding() async {
    return await userLoginDataProvider.getCurrentBuild();
  }

  Future<UserEntity> _login(String userName, String passWord) async {
    _userEntity = await userLoginDataProvider.login(userName, passWord);
    List<LoginUserInfo> infos = await userLoginDataProvider.getSavedUserInfos();
    if (infos == null) {
      infos = List();
    }
    if (infos.map((item) => item.username).toSet().contains(userName)) {
      int index = infos.indexWhere((item) => item.username == userName);
      infos[index].password = passWord;
    } else {
      LoginUserInfo thisInfo =
          LoginUserInfo(username: userName, password: passWord);
      infos.add(thisInfo);
    }
    userLoginDataProvider.writeSavedUserInfos(infos);
    _currentBuild = await userLoginDataProvider.getCurrentBuild();
    userLoginDataProvider.setUpJpush(_userEntity);
    return _userEntity;
  }

  Future<List<LoginUserInfo>> deleteLoginUserInfo(String userName) async {
    List<LoginUserInfo> infos = await userLoginDataProvider.getSavedUserInfos();
    if (infos.isEmpty || infos == null) return infos;
    infos.removeWhere((item) => item.username == userName);
    userLoginDataProvider.writeSavedUserInfos(infos);
    return infos;
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
