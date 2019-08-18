import 'package:dio/dio.dart';

///@author ggq
///@description:
///@date :2019/8/15 10:43
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // for the utf8.encode method

void main() {
  group(("mocking testsp"), () {
    String prefixKey = "flutter.";
    String prefixUserName = prefixKey + USER_NAME;
    String prefixPassWord = prefixKey + PASS_WORD;
    setUp(() {
      SharedPreferences.setMockInitialValues(
          {prefixUserName: "hyj1", prefixPassWord: "123456"});
    });
    test(("read"), () async {
      Application.prefs = await SharedPreferences.getInstance();
      Response res =
          await DioUtils.getInstance().getDio().get("/user/projects/role/17");
      print(res);
    });
  });
}
