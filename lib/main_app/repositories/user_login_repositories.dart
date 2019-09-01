import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/auth.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

///@author ggq
///@description:
///@date :2019/8/25 18:35

class UserLoginDataProvider {
  final JPush jPush;

  UserLoginDataProvider([jPush]) : jPush = jPush ?? JPush();

  Future<UserEntity> login(String userName, String passWord) async {
    Response res = await DioUtils.getInstance().login(userName, passWord);
    var model = UserEntity.fromJson(res.data['data']);
    await Auth.getInstance().save(userName, passWord);
    return model;
  }

  Future setUpJpush(String alias, String tag) async {
    jPush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );
    jPush.setup(
      appKey: "82a1ab81c8b060a42cdc62e1",
      channel: "theChannel",
      production: false,
      debug: false, // 设置是否打印 debug 日志
    );
    Map tags = await jPush.getAllTags();
    if (!tags.containsValue(tag)) {
      await jPush.setTags([tag]);
    }
    Map a = await jPush.setAlias(alias);
    print(a);
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
    await _login(userName, passWord);
  }

  Future<void> loginWithLocal() async {
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    await _login(userName, passWord);
  }

  Future<void> _login(String userName, String passWord) async {
    _userEntity = await userLoginDataProvider.login(userName, passWord);
    _currentBuild = await userLoginDataProvider.getCurrentBuild();
    await userLoginDataProvider.setUpJpush(
        "USER_${_userEntity.userName}", "FIRE_${_userEntity.buildingCode}");
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
