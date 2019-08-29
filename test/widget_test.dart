// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/module1/action/Moudle1Action.dart';
import 'package:ifcy/module1/model/Moudle1Model.dart';
import 'package:ifcy/common/utils/StoreCreater.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/main.dart';
import 'package:ifcy/module1/MoudleRedux.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifcy/common/res/res.dart';

aa() async {
  await Future.delayed(Duration(seconds: 1));
  print("sss");
}

void main() {
  group(("other"), () {
    //  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
    test("testjson", () async {
      Dio dio = Dio()
        ..options.baseUrl = "http://116.56.140.193/business/app/api";
//    dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.receiveDataWhenStatusError = true;
      dio.options.contentType = ContentType.json;
      var ss = await dio.post(
        "/anonymous/login",
        data: '{"password": "123456", "username": "hyj"}',
      );
      print(ss.headers.value("authorization"));
      var s1 = await dio.get("/user/projects",
          options:
              Options(headers: {"authorization": ss.headers['authorization']}));
      print(s1);
    });
    test("testjson1", () async {
      Dio dio = Dio()
        ..options.baseUrl = "http://116.56.140.193/business/app/api";
      dio.options.receiveDataWhenStatusError = true;
      dio.options.contentType = ContentType.json;
      dio.interceptors.add(InterceptorsWrapper(onError: (e) {
        print(e.toString());
      }));
      try {
        var s1 = await dio.get("/user/projects",
            options: Options(headers: {"authorization": "11111"}));
        print(s1);
      } on DioError catch (e) {
        print(e);
      }
    });
    test("tt11", () {
      var rr = RegularInspectionTaskDetail.generate("1");
      print(jsonEncode(rr));
      print(RegularInspectionTaskDetail.fromJson(jsonDecode(json.encode(rr)))
          .taskStatus
          .runtimeType);
    });
    test("testcmp", () async {
      var a = {1, 2, 3};
      var b = {1, 2, 4};
      print(a.difference(b).isEmpty);
    });
    test("testdateTime", () async {
      Dio dio = DioUtils.getInstance().getDio();
      await DioUtils.getInstance().login("hyj", "123456");
      Response res = await dio.get("/user/projects/role/17");
      Response re = await dio.get("/building/project/17");
      print(re);
    });
    test("testadd", () async {
      await DioUtils.getInstance().login("hyj", "123456");
      Response res =
          await DioUtils.getInstance().getDio().get("/patrol/tasks");
      var aa = InspectionTaskPageModel.fromJson(res.data['data']);
      print(aa);
    });
  });

  group(("mocking testsp"), () {
    String prefixKey = "flutter.";
    String prefixUserName = prefixKey + USER_NAME;
    String prefixPassWord = prefixKey + PASS_WORD;
    setUp(() {
      SharedPreferences.setMockInitialValues(
          {prefixUserName: "hello", prefixPassWord: "123456"});
    });
    test(("read"), () async {
      Application.prefs = await SharedPreferences.getInstance();
      Response res =
          await DioUtils.getInstance().getDio().get("/user/projects");
      print(res);
    });
  });
}
