class LoginSuccessAction {
  String userName;
  List projectList;
  Map project2Auth;

  LoginSuccessAction(
    this.userName,
    this.projectList,
    this.project2Auth,
  );
}

class ChangeAlertAction {
  String alertText;

  ChangeAlertAction(this.alertText);
}

class OnChangeProject{
  String selectedProject;
  int index;
  String auth;

  OnChangeProject(this.selectedProject, this.index, this.auth);

}