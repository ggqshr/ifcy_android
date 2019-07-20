import 'package:flutter/material.dart';
import 'package:ifcy/main_app/pages/login_page.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'package:redux/redux.dart';
import 'model/AppState.dart';
import 'package:ifcy/main_app_redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifcy/utils/constant_name.dart';
import 'package:ifcy/utils/loading.dart';

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MainApp(),
    );
  }
}

class _MainApp extends StatefulWidget {
  @override
  __MainAppState createState() => __MainAppState();
}

class __MainAppState extends State<_MainApp> {
  Widget view;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    ///todo 判断是否登陆，显示不同的内容

    String label = null;
    if (label == null) {
      //未登录
      view = LoginPage();
    } else {
      //登陆
    }
  }

  @override
  Widget build(BuildContext context) {
    loadingDialogAction = LoadingDialogAction(context);
    return Scaffold(
      body: view,
    );
  }
}
