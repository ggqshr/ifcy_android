import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/utils/utils.dart';
import 'device_staff/model/device_staff_model.dart';
import 'device_supervisor/model/device_supervisor_model.dart';
import 'main_app/main_app.dart';
import 'main_app/model/AppState.dart';
import 'main_app/model/select_project_model.dart';
import 'common/utils/StoreCreater.dart';
import 'package:ifcy/main_app_redux.dart';

void main() {
  // 注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  Store<AppState> _store = createStoreWithmiddleware<AppState>(
      mainAppReducer,
      AppState(
        selectProjectModel: SelectProjectModel(),
        deviceSupervisorModel: DeviceSupervisorModel.init(),
        deviceStaffModel: DeviceStaffModel.init(),
      ),
      null);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    SharedPreferences.getInstance().then((res) {
      Application.prefs = res;
    });

    return StoreProvider<AppState>(
      store: _store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green[300],
        ),
        home: MainApp(),
        onGenerateRoute: Application.router.generator,
        navigatorKey: Application.navigatorKey,
      ),
    );
  }
}
