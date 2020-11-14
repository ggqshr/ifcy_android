import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/blocs/error_process_delegate.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:ifcy/main_app_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'building_owner/model/building_owner_model.dart';
import 'common/utils/StoreCreater.dart';
import 'common/utils/utils.dart';
import 'device_staff/model/device_staff_model.dart';
import 'device_supervisor/model/device_supervisor_model.dart';
import 'main_app/main_app.dart';
import 'main_app/model/AppState.dart';
import 'main_app/model/select_project_model.dart';

void main() {

  // 注册 fluro routes
  runApp(MyApp());
//  SystemUiOverlayStyle systemUiOverlayStyle =
//      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  Store<AppState> _store = createStoreWithmiddleware<AppState>(
      mainAppReducer,
      AppState(
        selectProjectModel: SelectProjectModel(),
        deviceSupervisorModel: DeviceSupervisorModel.init(),
        deviceStaffModel: DeviceStaffModel.init(),
        buildingOwnerModel: BuildingOwnerModel.init(),
      ),
      null);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((res) {
      Application.prefs = res;
    });

    return StoreProvider<AppState>(
      store: _store,
      child: RepositoryProvider(
        create: (context) => UserLoginRepositories(),
        child: BlocProvider(
          create: (context) {
            var bloc = AuthorizationBloc(RepositoryProvider.of(context))
              ..add(AppStart());
            BlocSupervisor.delegate = ErrorProcessDelegate(bloc);
            return bloc;
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.green[300],
            ),
            home: SafeArea(
              child: MainApp(),
            ),
            navigatorKey: Application.navigatorKey,
          ),
        ),
      ),
    );
  }
}
