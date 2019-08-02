import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/select_project_reducer.dart';
import 'package:redux/redux.dart';

import 'device_supervisor/device_supervisor_redux.dart';
import 'main_app/actions/main_app_actions.dart';

String updateUserName(String userName, action) {
  return action.userName;
}

Reducer<String> UserNameReduer = combineReducers([
  TypedReducer<String, LoginSuccessAction>(updateUserName),
]);

String changeAlertText(String alertText, action) {
  return action.alertText;
}

Reducer<String> AlertTextReducer = combineReducers([
  TypedReducer<String, ChangeAlertAction>(changeAlertText),
]);

Map changeProject2Auth(Map project2Auth, action) {
  return action.project2Auth;
}

Reducer<Map> Project2AuthReducer = combineReducers([
  TypedReducer<Map, LoginSuccessAction>(changeProject2Auth),
]);

AppState mainAppReducer(AppState state, action) {
  print(action);
  return AppState(
    userName: UserNameReduer(state.userName, action),
    alertText: AlertTextReducer(state.alertText, action),
    project2Auth: Project2AuthReducer(state.project2Auth, action),
    selectProjectModel: SelectProjectReducer(state.selectProjectModel, action),
    deviceSupervisorModel:
        deviceSupervisorModule1Reducer(state.deviceSupervisorModel, action),
  );
}
