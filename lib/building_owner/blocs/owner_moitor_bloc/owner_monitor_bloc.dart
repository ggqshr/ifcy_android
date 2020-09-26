import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/building_owner/repositories/building_owner_repositories.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import './bloc.dart';

class OwnerMonitorBloc extends Bloc<OwnerMonitorEvent, OwnerMonitorState> {
  final OwnerMonitorRepositories repositories;
  final UserLoginRepositories loginRepositories;

  OwnerMonitorBloc(this.repositories, this.loginRepositories);

  @override
  OwnerMonitorState get initialState => LoadingOwnerMonitorDataState();

  @override
  Stream<OwnerMonitorState> mapEventToState(
    OwnerMonitorEvent event,
  ) async* {
    if (event is FetchOwnerMonitorDataEvent) {
      yield* _mapFetchToState();
    } else if (event is UpdateOwnerMonitorDataEvent) {
      yield* _mapUpdateToState(event);
    }
  }

  Stream<OwnerMonitorState> _mapUpdateToState(
      UpdateOwnerMonitorDataEvent event) async* {
    try {
      if (state is LoadedOwnerMonitorDataState) {
        String thisUserName = loginRepositories.getUser.userName; // 获取当前的用户名
        repositories.setBlockDevice(
            thisUserName, event.deviceCode, event.blockOutTime);
        yield (state as LoadedOwnerMonitorDataState).copyWith(
          fireAlarmMsg: await repositories.getFireAlarmMsg(thisUserName),
        );
      }
    } catch (e) {
      yield LoadErrorOwnerMonitorDataState();
      rethrow;
    }
  }

  Stream<OwnerMonitorState> _mapFetchToState() async* {
    try {
      String thisUserName = loginRepositories.getUser.userName; // 获取当前的用户名
      if (state is LoadingOwnerMonitorDataState ||
          state is LoadErrorOwnerMonitorDataState) {
        yield LoadedOwnerMonitorDataState(
          trueFireNum: await repositories.getTrueFireNum(),
          fireNum: await repositories.getFireNum(),
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(thisUserName),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
          userList: await repositories.getUserList(),
        );
      } else if (state is LoadedOwnerMonitorDataState) {
        yield LoadedOwnerMonitorDataState(
          trueFireNum: await repositories.getTrueFireNum(),
          fireNum: await repositories.getFireNum(),
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(thisUserName),
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
