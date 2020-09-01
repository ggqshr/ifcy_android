import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';

part 'remember_event.dart';

part 'remember_state.dart';

class RememberBloc extends Bloc<RememberEvent, RememberState> {
  final UserLoginRepositories userLoginRepositories;

  RememberBloc(this.userLoginRepositories);

  @override
  Stream<RememberState> mapEventToState(
    RememberEvent event,
  ) async* {
    if (event is FetchUserLoginInfosEvent) {
      List<LoginUserInfo> infos =
          await userLoginRepositories.getLoginUserInfos();
      RememberLoadedState state = RememberLoadedState(infos);
      yield state;
    } else if (event is DeleteUserLoginInfosEvent) {
      String delUserName = event.userName;
      List<LoginUserInfo> infos =
          await userLoginRepositories.deleteLoginUserInfo(delUserName);
      RememberLoadedState state = RememberLoadedState(infos);
      yield state;
    }
  }

  @override
  RememberState get initialState => RememberInitial();
}
