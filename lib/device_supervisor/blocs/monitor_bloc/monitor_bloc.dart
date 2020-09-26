import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';

import './bloc.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  final MonitorRepositories repositories;
  final UserLoginRepositories loginRepositories;

  MonitorBloc(this.loginRepositories, [repo])
      : repositories = repo ?? MonitorRepositories();

  @override
  MonitorState get initialState => UnInitializationMonitorState();

  @override
  Stream<MonitorState> mapEventToState(
    MonitorEvent event,
  ) async* {
    if (event is FetchMonitorDataEvent) {
      yield* _mapFetchToState();
    } else if (event is UpdateMonitorDataEvent) {
      yield* _mapUpdateToState(event);
    }
  }

  Stream<MonitorState> _mapUpdateToState(UpdateMonitorDataEvent event) async* {
    try {
      if (state is LoadedMonitorState) {
        String thisUserName = loginRepositories.getUser.userName; // 获取当前的用户名
        repositories.setBlockDevice(
            thisUserName, event.deviceCode, event.blockOutTime);
        yield (state as LoadedMonitorState).copy(
          fireAlarmMsg: await repositories.getFireAlarmMsg(thisUserName),
        );
      }
    } catch (e) {
      yield LoadedErrorMonitorState();
      rethrow;
    }
  }

  Stream<MonitorState> _mapFetchToState() async* {
    try {
      String userName = loginRepositories.getUser.userName;
      if (state is UnInitializationMonitorState ||
          state is LoadedErrorMonitorState) {
        List allData = await Future.wait(
            [
              repositories.getDeviceFaultNum(),
              repositories.getDeviceFaultMsg(),
              repositories.getFireAlarmMsg(userName),
              repositories.getTaskCompleteRate(),
              repositories.getTaskInfoMsg(),
              repositories.getTrueFireNum(),
            ]
        );
        yield LoadedMonitorState(
          deviceFaultNum: allData[0],
          deviceFaultMsg: allData[1],
          fireAlarmMsg: allData[2],
          taskCompleteRate: allData[3],
          taskInfoMsg: allData[4],
          trueFireNum: allData[5],
        );
      } else if (state is LoadedMonitorState) {
        List allData = await Future.wait(
            [
              repositories.getDeviceFaultNum(),
              repositories.getDeviceFaultMsg(),
              repositories.getFireAlarmMsg(userName),
              repositories.getTaskCompleteRate(),
              repositories.getTaskInfoMsg(),
              repositories.getTrueFireNum(),
            ]
        );
        yield (state as LoadedMonitorState).copy(
          deviceFaultNum: allData[0],
          deviceFaultMsg: allData[1],
          fireAlarmMsg: allData[2],
          taskCompleteRate: allData[3],
          taskInfoMsg: allData[4],
          trueFireNum: allData[5],
        );
      }
    } catch (e) {
      yield LoadedErrorMonitorState();
      rethrow;
    }
  }
}
