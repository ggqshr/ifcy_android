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
  Stream<MonitorState> mapEventToState(MonitorEvent event,) async* {
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
        yield LoadedMonitorState(
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(userName),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
        );
      } else if (state is LoadedMonitorState) {
        yield (state as LoadedMonitorState).copy(
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(userName),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
        );
      }
    } catch (e) {
      yield LoadedErrorMonitorState();
      rethrow;
    }
  }
}
