import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';

import 'actions/main_app_actions.dart';
import 'model/select_project_model.dart';

SelectProjectModel SelectProjectReducer(SelectProjectModel model, action) {
  return SelectProjectModel(
    selectedProjectIndex:
        CurrentProjectIndexReducer(model.selectedProjectIndex, action),
    selectedProject: selectProjectReducer(model.selectedProject, action),
    auth: CurrentAuth(model.auth, action),
    projectList: ProjectListReducer(model.projectList, action),
  );
}

int changeProjectIndex(int currentIndex, action) {
  return 0;
}

int updateIndex(int currentIndex, action) {
  return (action as OnChangeProjectAction).index;
}

Reducer<int> CurrentProjectIndexReducer = combineReducers([
  TypedReducer<int, LoginSuccessAction>(changeProjectIndex),
  TypedReducer<int, OnChangeProjectAction>(updateIndex),
]);

Projects changeSelectedProject(Projects selectedProject, action) {
  return (action as LoginSuccessAction).projectList[action.currentProIndex];
}

Projects onChangeProject(Projects selectedProject, action) {
  return action.selectedProject;
}

Reducer<Projects> selectProjectReducer = combineReducers([
  TypedReducer<Projects, LoginSuccessAction>(changeSelectedProject),
  TypedReducer<Projects, OnChangeProjectAction>(onChangeProject),
]);

String changeCurrentAuth(String currentAuth, action) {
  return (action as LoginSuccessAction).auth;
}

String updateAuth(String currentAuth, action) {
  return (action as OnChangeProjectAction).auth;
}

Reducer<String> CurrentAuth = combineReducers([
  TypedReducer<String, LoginSuccessAction>(changeCurrentAuth),
  TypedReducer<String, OnChangeProjectAction>(updateAuth),
]);

List updateProjectList(List projectList, action) {
  return action.projectList;
}

Reducer<List> ProjectListReducer = combineReducers([
  TypedReducer<List, LoginSuccessAction>(updateProjectList),
]);
