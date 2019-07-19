import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';

import 'actions/main_app_actions.dart';

String updateUserName(String userName, action) {
  return action.userName;
}

Reducer<String> UserNameReduer = combineReducers([
  TypedReducer<String, LoginSuccessAction>(updateUserName),
]);

List updateAuth(List auth, action) {
  return action.auth;
}

Reducer<List> AuthReducer = combineReducers([
  TypedReducer<List, LoginSuccessAction>(updateAuth),
]);

String changeAlertText(String alertText, action) {
  return action.alertText;
}

Reducer<String> AlertTextReducer = combineReducers([
  TypedReducer<String, ChangeAlertAction>(changeAlertText),
]);

AppState mainAppReducer(AppState state, action) => AppState(
      userName: UserNameReduer(state.userName, action),
      auth: AuthReducer(state.auth, action),
      alertText: AlertTextReducer(state.alertText, action),
    );
