import 'package:flutter/material.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'package:redux/redux.dart';
import 'model/AppState.dart';
import 'main_app_redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainApp extends StatelessWidget {
  Store<AppState> _store =
      createStoreWithmiddleware<AppState>(mainAppReducer, AppState(), null);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: _store,
      child: Scaffold(
        body: _MainApp(),
      ),
    );
  }
}

class _MainApp extends StatefulWidget {
  @override
  __MainAppState createState() => __MainAppState();
}

class __MainAppState extends State<_MainApp> {



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
