import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
// for the utf8.encode method

void main() {
  // group(("mocking testsp"), () {
  //   String prefixKey = "flutter.";
  //   String prefixUserName = prefixKey + USER_NAME;
  //   String prefixPassWord = prefixKey + PASS_WORD;
  //   setUp(() {
  //     SharedPreferences.setMockInitialValues(
  //         {prefixUserName: "hyj1", prefixPassWord: "123456"});
  //   });
  //   test(("read"), () async {
  //     Application.prefs = await SharedPreferences.getInstance();
  //     Response res =
  //         await DioUtils.getInstance().getDio().get("/user/projects/role/17");
  //     print(res);
  //   });
  // });
  test(("json"), () {
    List<LoginUserInfo> users = [
      LoginUserInfo(username: "1", password: "2"),
      LoginUserInfo(username: "3", password: "5"),
      LoginUserInfo(username: "2", password: "1"),
    ];
    print(users.toSet().contains(LoginUserInfo(username: "2", password: "2")));
  });
}
