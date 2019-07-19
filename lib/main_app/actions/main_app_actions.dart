class LoginSuccessAction {
  String userName;
  List auth;

  LoginSuccessAction(
    this.userName,
    this.auth,
  );
}

class ChangeAlertAction {
  String alertText;

  ChangeAlertAction(this.alertText);
}
