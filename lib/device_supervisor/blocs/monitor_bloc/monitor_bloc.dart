import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import './bloc.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  final MonitorRepositories repositories;

  MonitorBloc([repo]) : repositories = repo ?? MonitorRepositories();

  @override
  MonitorState get initialState => UnInitializationMonitorState();

  @override
  Stream<MonitorState> mapEventToState(
    MonitorEvent event,
  ) async* {
    if (event is FetchMonitorDataEvent) {
      yield* _mapFetchToState();
    }
  }

  Stream<MonitorState> _mapFetchToState() async* {
    try {
      if (state is UnInitializationMonitorState ||
          state is LoadedErrorMonitorState) {
        yield LoadedMonitorState(
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(),
          taskCompleteRate: await repositories.getTaskCompleteRate(),
          taskInfoMsg: await repositories.getTaskInfoMsg(),
        );
      } else if (state is LoadedMonitorState) {
        yield (state as LoadedMonitorState).copy(
          deviceFaultNum: await repositories.getDeviceFaultNum(),
          deviceFaultMsg: await repositories.getDeviceFaultMsg(),
          fireAlarmMsg: await repositories.getFireAlarmMsg(),
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
