import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/model/AppState.dart';
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
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! UserNameChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is UserNameChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
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
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String userName) async* {
    yield currentState.update(isUserNameValid: userName.isNotEmpty);
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(isPasswordValid: password.isNotEmpty);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String username, String password}) async* {
    yield LoginState.loading();
    try {
      UserEntity userEntity =
          await userLoginRepositories.login(username, password);
      yield LoginState.success();
      authorizationBloc.dispatch(LoginIn(userEntity: userEntity));
    } catch (_) {
      yield LoginState.failure();
      rethrow;
    }
  }
}
