// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/module1/action/Moudle1Action.dart';
import 'package:ifcy/module1/model/Moudle1Model.dart';
import 'package:ifcy/common/utils/StoreCreater.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/main.dart';
import 'package:ifcy/module1/MoudleRedux.dart';

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
  test("testjson", ()async  {
    Dio dio = Dio()..options.baseUrl = "http://116.56.140.193/business/app/api";
    dio.options.receiveDataWhenStatusError=true;
    dio.options.contentType=ContentType.json;
      var ss = await dio.post(
        "/anonymous/login",
        data: '{"password": "123456", "username": "hyj"}',
      );
      var s1 = await dio.get("/user/projects",options: Options(headers: {"authorization":ss.headers['authorization']}));
      print(s1);
  });
  test("tt",(){
    print(parseEnumType(TaskStatus.completed));
  });
}
