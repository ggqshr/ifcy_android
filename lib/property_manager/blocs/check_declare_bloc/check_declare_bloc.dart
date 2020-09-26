import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/property_manager/repositories/check_declare_repositories.dart';

import './bloc.dart';

class CheckDeclareBloc extends Bloc<CheckDeclareEvent, CheckDeclareState> {
  final CheckDeclareRepositories repo;

  CheckDeclareBloc(this.repo);

  @override
  CheckDeclareState get initialState => CheckStatusDeclareState.init();

  @override
  Stream<CheckDeclareState> mapEventToState(
    CheckDeclareEvent event,
  ) async* {
    if (event is CheckPassDeclareMessageEvent) {
      try {
        yield CheckStatusDeclareState.checking();
        repo.checkPassDeclare(event.id);
        yield CheckStatusDeclareState.success();
      } catch (e) {
        yield CheckStatusDeclareState.fault();
        rethrow;
      }
    }
  }
}
