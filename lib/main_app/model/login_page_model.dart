part of 'AppState.dart';

class LoginPageModel {
  String alertText;
  Function submitCall;

  LoginPageModel({this.submitCall, this.alertText});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LoginPageModel &&
              runtimeType == other.runtimeType &&
              alertText == other.alertText;

  @override
  int get hashCode => alertText.hashCode;



}
