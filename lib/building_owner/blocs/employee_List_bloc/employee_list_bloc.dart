import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/building_owner/repositories/building_owner_repositories.dart';

import './bloc.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeRepositories repositories;

  EmployeeListBloc(this.repositories);

  @override
  EmployeeListState get initialState => LoadingEmployeeListState();

  @override
  Stream<EmployeeListState> mapEventToState(
    EmployeeListEvent event,
  ) async* {
    if (event is FetchEmployeeListDataEvent) {
      yield* _mapFetchToState();
    }
  }

  Stream<EmployeeListState> _mapFetchToState() async* {
    try {
      yield LoadedEmployeeListState(await repositories.getAllUser());
    } catch (e) {
      yield LoadErrorEmployeeListState();
      rethrow;
    }
  }
}
