class LoginSuccessAction {
  String userName;
  List projectList;
  Map project2Auth;
  int currentProIndex;

  LoginSuccessAction(
    this.userName,
    this.projectList,
    this.project2Auth,
    this.currentProIndex,
  );
}

class ChangeAlertAction {
  String alertText;

  ChangeAlertAction(this.alertText);
}

class OnChangeProject {
  String selectedProject;
  int index;
  String auth;

  OnChangeProject(this.selectedProject, this.index, this.auth);
}
