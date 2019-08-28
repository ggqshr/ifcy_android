import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import './bloc.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  UserLoginRepositories userLoginRepositories;

  AuthorizationBloc(this.userLoginRepositories);

  @override
  AuthorizationState get initialState => Uninitialized();

  @override
  Stream<AuthorizationState> mapEventToState(
    AuthorizationEvent event,
  ) async* {
    if (event is AppStart) {
      yield* _mapAppStartEventToState();
    }
    if (event is LoginIn) {
      yield* _mapLoginInEventToState(event);
    }
    if (event is LoginOut) {
      yield* _mapLoggedOutToState();
    }
    if(event is ShouldReLogin){
      yield Unauthenticated();
    }
  }

  Stream<AuthorizationState> _mapAppStartEventToState() async* {
    try {
      final isSignIn = await userLoginRepositories.isLoginIn();
      if (isSignIn) {
        await userLoginRepositories.loginWithLocal();
        yield Authenticated(userEntity: userLoginRepositories.getUser);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield Unauthenticated();
      rethrow;
    }
  }

  Stream<AuthorizationState> _mapLoginInEventToState(
      AuthorizationEvent event) async* {
    yield Authenticated(userEntity: userLoginRepositories.getUser);
  }

  Stream<AuthorizationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    userLoginRepositories.signOut();
  }
}
