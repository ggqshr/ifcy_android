import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';

import 'actions/main_app_actions.dart';

String updateUserName(String userName, action) {
  return action.userName;
}

Reducer<String> UserNameReduer = combineReducers([
  TypedReducer<String, LoginSuccessAction>(updateUserName),
]);

List updateProjectList(List projectList, action) {
  return action.projectList;
}

Reducer<List> AuthReducer = combineReducers([
  TypedReducer<List, LoginSuccessAction>(updateProjectList),
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

String changeCurrentAuth(String currentAuth, action) {
  return (action as LoginSuccessAction).project2Auth[action.projectList[0]];
}

String updateAuth(String currentAuth, action) {
  return (action as OnChangeProject).auth;
}

Reducer<String> CurrentAuth = combineReducers([
  TypedReducer<String, LoginSuccessAction>(changeCurrentAuth),
  TypedReducer<String, OnChangeProject>(updateAuth),
]);

int changeProjectIndex(int currentIndex, action) {
  return 0;
}

int updateIndex(int currentIndex, action) {
  return (action as OnChangeProject).index;
}

Reducer<int> CurrentProjectIndexReducer = combineReducers([
  TypedReducer<int, LoginSuccessAction>(changeProjectIndex),
  TypedReducer<int, OnChangeProject>(updateIndex),
]);

AppState mainAppReducer(AppState state, action) => AppState(
      userName: UserNameReduer(state.userName, action),
      projectList: AuthReducer(state.projectList, action),
      alertText: AlertTextReducer(state.alertText, action),
      project2Auth: Project2AuthReducer(state.project2Auth, action),
      currentAuth: CurrentAuth(state.currentAuth, action),
      currentProjectIndex:
          CurrentProjectIndexReducer(state.currentProjectIndex, action),
    );
