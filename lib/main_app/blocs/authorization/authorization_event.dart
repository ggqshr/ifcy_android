import 'package:equatable/equatable.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthorizationEvent extends Equatable {
  AuthorizationEvent([List props = const []]) : super(props);
}

class AppStart extends AuthorizationEvent {}

class LoginIn extends AuthorizationEvent {}

class LoginOut extends AuthorizationEvent {}
