import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'main_app/main_app.dart';
import 'main_app/model/AppState.dart';
import 'main_app/model/select_project_model.dart';
import 'utils/StoreCreater.dart';
import 'package:ifcy/main_app_redux.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  Store<AppState> _store =
      createStoreWithmiddleware<AppState>(mainAppReducer, AppState(selectProjectModel: SelectProjectModel()), null);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: _store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainApp(),
      ),
    );
  }
}
