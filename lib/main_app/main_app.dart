import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_state.dart';
import 'package:ifcy/main_app/blocs/login/bloc.dart';
import 'package:ifcy/main_app/pages/login_page.dart';
import 'package:ifcy/main_app/pages/select_project_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repositories/user_login_repositories.dart';

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
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    loadingDialogAction = LoadingDialogAction(context);
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Uninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Authenticated) {
          return SelectProjectPage();
        }
        if (state is Unauthenticated) {
          return LoginPage();
        }
      },
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
