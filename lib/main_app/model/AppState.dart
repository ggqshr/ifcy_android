part 'login_page_model.dart';

class AppState {
  String userName;
  List projectList;
  String alertText;
  Map project2Auth;
  String currentAuth;
  int currentProjectIndex = 0;

  AppState({
    this.userName,
    this.projectList,
    this.alertText,
    this.project2Auth,
    this.currentAuth,
    this.currentProjectIndex,
  });
}
