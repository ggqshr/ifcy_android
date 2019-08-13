// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/module1/action/Moudle1Action.dart';
import 'package:ifcy/module1/model/Moudle1Model.dart';
import 'package:ifcy/common/utils/StoreCreater.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/main.dart';
import 'package:ifcy/module1/MoudleRedux.dart';
import 'package:path/path.dart' as p;
aa()async{
  await Future.delayed(Duration(seconds: 1));
  print("sss");
}
void main() {
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
    Dio dio = Dio()..options.baseUrl = "http://116.56.140.193/business/app/api";
    dio.options.receiveDataWhenStatusError = true;
    dio.options.contentType = ContentType.json;
    var ss = await dio.post(
      "/anonymous/login",
      data: '{"password": "123456", "username": "hyj"}',
    );
    var s1 = await dio.get("/user/projects",
        options:
            Options(headers: {"authorization": ss.headers['authorization']}));
    print(s1);
  });
  test("tt11", () {
    var rr = RegularInspectionTaskDetail.generate("1");
    print(jsonEncode(rr));
    print(RegularInspectionTaskDetail.fromJson(jsonDecode(json.encode(rr)))
        .taskStatus
        .runtimeType);
  });
  test("tt12", () {
//    var tt = TaskInfoDetailListBloc.localInit(List.generate(20, (index) {
//      return RegularInspectionTaskDetail.generate(index.toString());
//    }));
//    tt.filterByTaskStatus(TaskStatus.uncompleted);
//    print(tt.list2show.every((item) {
//      return item.taskStatus == TaskStatus.uncompleted;
//    }));
  });
  test("testdb", ()  {
    var ss = TaskInfoDetailListBloc.localInit("1");
    print(ss);
  });

}
