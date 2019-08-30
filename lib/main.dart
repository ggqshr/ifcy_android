import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/blocs/error_process_delegate.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
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
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  // 注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  JPush jpush = new JPush();
  jpush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter onReceiveNotification: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter onOpenNotification: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter onReceiveMessage: $message");
    },
  );
  jpush.setup(
    appKey: "82a1ab81c8b060a42cdc62e1",
    channel: "theChannel",
    production: false,
    debug: false, // 设置是否打印 debug 日志
  );
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
      child: RepositoryProvider(
        builder: (context) => UserLoginRepositories(),
        child: BlocProvider(
          builder: (context) {
            var bloc = AuthorizationBloc(RepositoryProvider.of(context))
              ..dispatch(AppStart());
            BlocSupervisor.delegate = ErrorProcessDelegate(bloc);
            return bloc;
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.green[300],
            ),
            home: MainApp(),
            onGenerateRoute: Application.router.generator,
            navigatorKey: Application.navigatorKey,
          ),
        ),
      ),
    );
  }
}
