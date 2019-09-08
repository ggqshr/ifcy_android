import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/select_project_reducer.dart';
import 'package:redux/redux.dart';

import 'common/utils/utils.dart';
import 'device_staff/device_staff_reducer.dart';
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

String initCompanyNameReducer(String companyName, action) {
  return action.companyName;
}

Reducer<String> CompanyNameReducer = combineReducers([
  TypedReducer<String, LoginSuccessAction>(initCompanyNameReducer),
]);

int initUserId(int userId, action) {
  return action.userId;
}

Reducer<int> UserIdReducer = combineReducers([
  TypedReducer<int, LoginSuccessAction>(initUserId),
]);

AppState mainAppReducer(AppState state, action) {
  print(action);
//  if (action is InternetAction) {
//    reactToInternetErrorReducer(null, action);
//  } else if (action is ErrorAction) {
//    print(action);
//    Application.showToast("错误${action.msg}", toastLength: Toast.LENGTH_LONG);
//  }
  return AppState(
    companyName: CompanyNameReducer(state.companyName, action),
    userId: UserIdReducer(state.userId, action),
    userName: UserNameReduer(state.userName, action),
    alertText: AlertTextReducer(state.alertText, action),
    selectProjectModel: SelectProjectReducer(state.selectProjectModel, action),
  );
}

//用于输出网络错误的reducer todo 写一个中间件
Reducer<void> reactToInternetErrorReducer = combineReducers([
  TypedReducer<void, InternalErrorAction>(
    (_, action) => Application.showToast(
        "服务器内部错误 ${action.code} ${action.msg} ${action.statusCode}",
        toastLength: Toast.LENGTH_LONG),
  ),
  TypedReducer<void, EmptyUserFieldAction>(
    (_, action) => Application.showToast(
        "空的用户名或者密码 ${action.code} ${action.msg} ${action.statusCode}",
        toastLength: Toast.LENGTH_LONG),
  ),
  TypedReducer<void, IncorrectUserErrorAction>(
    (_, action) => Application.showToast(
        "用户名密码不正确 ${action.code} ${action.msg} ${action.statusCode}",
        toastLength: Toast.LENGTH_LONG),
  ),
  TypedReducer<void, UnknownErrorAction>(
    (_, action) => Application.showToast(
        "未知错误 ${action.code} ${action.msg} ${action.statusCode}",
        toastLength: Toast.LENGTH_LONG),
  ),
]);
