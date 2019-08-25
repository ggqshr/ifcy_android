import 'package:equatable/equatable.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthorizationState extends Equatable {
  AuthorizationState([List props = const []]) : super(props);
}

///未初始化
class Uninitialized extends AuthorizationState {}

///已授权
class Authenticated extends AuthorizationState {
  final UserEntity userEntity;

  Authenticated({this.userEntity}) : super([userEntity]);
}

///未授权
class Unauthenticated extends AuthorizationState {}
