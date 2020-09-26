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
        List allData = await Future.wait([
          repositories.getTrueFireNum(),
          repositories.getFireNum(),
          repositories.getDeviceFaultNum(),
          repositories.getTaskCompleteRate(),
          repositories.getFireAlarmMsg(thisUserName),
          repositories.getDeviceFaultMsg(),
          repositories.getTaskInfoMsg(),
          repositories.getUserList(),
        ]);
        yield LoadedOwnerMonitorDataState(
          trueFireNum: allData[0],
          fireNum: allData[1],
          deviceFaultNum: allData[2],
          taskCompleteRate: allData[3],
          fireAlarmMsg: allData[4],
          deviceFaultMsg: allData[5],
          taskInfoMsg: allData[6],
          userList: allData[7],
        );
      } else if (state is LoadedOwnerMonitorDataState) {
        List allData = await Future.wait([
          repositories.getTrueFireNum(),
          repositories.getFireNum(),
          repositories.getDeviceFaultNum(),
          repositories.getTaskCompleteRate(),
          repositories.getFireAlarmMsg(thisUserName),
          repositories.getDeviceFaultMsg(),
          repositories.getTaskInfoMsg(),
          repositories.getUserList(),
        ]);
        yield LoadedOwnerMonitorDataState(
          trueFireNum: allData[0],
          fireNum: allData[1],
          deviceFaultNum: allData[2],
          taskCompleteRate: allData[3],
          fireAlarmMsg: allData[4],
          deviceFaultMsg: allData[5],
          taskInfoMsg: allData[6],
          userList: allData[7],
        );
      }
    } catch (e) {
      yield LoadErrorOwnerMonitorDataState();
      rethrow;
    }
  }
}
