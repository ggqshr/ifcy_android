import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class TestPage extends StatelessWidget {
  String a, b;

  TestPage(this.a, this.b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$a,$b"),
      ),
    );
  }
}
