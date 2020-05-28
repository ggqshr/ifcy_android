import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/building_owner/repositories/building_owner_repositories.dart';
import './bloc.dart';

class OwnerMonitorBloc extends Bloc<OwnerMonitorEvent, OwnerMonitorState> {
  final OwnerMonitorRepositories repositories;

  OwnerMonitorBloc(this.repositories);

  @override
  OwnerMonitorState get initialState => LoadingOwnerMonitorDataState();

  @override
  Stream<OwnerMonitorState> mapEventToState(
    OwnerMonitorEvent event,
  ) async* {
    if (event is FetchOwnerMonitorDataEvent) {
      yield* _mapFetchToState();
    }
  }

  Stream<OwnerMonitorState> _mapFetchToState() async* {
    try {
      if (state is LoadingOwnerMonitorDataState ||
          state is LoadErrorOwnerMonitorDataState) {
        yield LoadedOwnerMonitorDataState(
          fireNum: await repositories.getFireNum(),
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
          userList: await repositories.getUserList(),
        );
      } else if (state is LoadedOwnerMonitorDataState) {
        yield LoadedOwnerMonitorDataState(
          fireNum: await repositories.getFireNum(),
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
          userList: await repositories.getUserList(),
        );
      }
    } catch (e) {
      yield LoadErrorOwnerMonitorDataState();
      rethrow;
    }
  }
}
