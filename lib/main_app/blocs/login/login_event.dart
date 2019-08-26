import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class UserNameChanged extends LoginEvent {
  final String userName;

  UserNameChanged({@required this.userName}) : super([userName]);

  @override
  String toString() => 'EmailChanged { email :$userName }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends LoginEvent {
  final String username;
  final String password;

  Submitted({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() {
    return 'Submitted { email: $username, password: $password }';
  }
}


class LoginWithCredentialsPressed extends LoginEvent {
  final String username;
  final String password;

  LoginWithCredentialsPressed({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $username, password: $password }';
  }
}