import 'actions/main_app_actions.dart';
import 'model/select_project_model.dart';
import 'package:redux/redux.dart';

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
  return (action as OnChangeProject).index;
}

Reducer<int> CurrentProjectIndexReducer = combineReducers([
  TypedReducer<int, LoginSuccessAction>(changeProjectIndex),
  TypedReducer<int, OnChangeProject>(updateIndex),
]);

String changeSelectedProject(String selectedProject, action) {
  return (action as LoginSuccessAction).projectList[action.currentProIndex];
}

String onChangeProject(String selectedProject, action) {
  return action.selectedProject;
}

Reducer<String> selectProjectReducer = combineReducers([
  TypedReducer<String, LoginSuccessAction>(changeSelectedProject),
  TypedReducer<String, OnChangeProject>(onChangeProject),
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

List updateProjectList(List projectList, action) {
  return action.projectList;
}

Reducer<List> ProjectListReducer = combineReducers([
  TypedReducer<List, LoginSuccessAction>(updateProjectList),
]);
