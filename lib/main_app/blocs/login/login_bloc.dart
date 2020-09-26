import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginRepositories userLoginRepositories;
  final AuthorizationBloc authorizationBloc;

  LoginBloc({this.userLoginRepositories, this.authorizationBloc});

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    Stream<Transition<LoginEvent, LoginState>> Function(LoginEvent event) next,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! UserNameChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is UserNameChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 500));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield* _mapEmailChangedToState(event.userName);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        username: event.username,
        password: event.password,
      );
    } else if (event is SelectExistsInfo) {
      yield state.update(
          isUserNameValid: event.info.username.isNotEmpty,
          isPasswordValid: event.info.password.isNotEmpty);
    } else if (event is ChangePasswordShow){
      yield state.showPassword();
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print("Login error");
    super.onError(error, stacktrace);
  }

  Stream<LoginState> _mapEmailChangedToState(String userName) async* {
    yield state.update(isUserNameValid: userName.isNotEmpty);
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: password.isNotEmpty);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String username, String password}) async* {
    yield LoginState.loading();
    try {
      await userLoginRepositories.login(username, password);
      yield LoginState.success();
      authorizationBloc.add(LoginIn());
    } catch (_) {
      yield LoginState.failure();
      rethrow;
    }
  }
}
