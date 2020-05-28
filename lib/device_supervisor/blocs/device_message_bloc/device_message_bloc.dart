import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/repositories/device_message_repositories.dart';
import './bloc.dart';

class DeviceMessageBloc extends Bloc<DeviceMessageEvent, DeviceMessageState> {
  DeviceMessageRepositories repositories;

  DeviceMessageBloc(this.repositories);

  @override
  DeviceMessageState get initialState => LoadingDeviceMessageState();

  @override
  Stream<DeviceMessageState> mapEventToState(
    DeviceMessageEvent event,
  ) async* {
    if (event is FetchAllDevices &&
        (state is LoadingDeviceMessageState ||
            state is LoadErrorDeviceMessageState)) {
      yield* _mapFetchAllToState();
    }
    if (event is FetchFaultDevices) {
      yield* _mapFetchFaultToState();
    }
    if (event is FetchRunningDevices) {
      yield* _mapFetchRunningToState();
    }
    try {
      if (event is RefreshFaultDevices) {
        final model = await repositories.getFaultDeviceFirstPage();
        yield (state as LoadedDeviceMessageState)
            .copy(faultListReachMax: false, faultDeviceList: model);
      }
      if (event is RefreshRunningDevices) {
        final model = await repositories.getRunningDeviceFirstPage();
        yield (state as LoadedDeviceMessageState)
            .copy(runningListReachMax: false, runningDeviceList: model);
      }
    } catch (e) {
      yield LoadErrorDeviceMessageState();
      rethrow;
    }
  }

  Stream<DeviceMessageState> _mapFetchAllToState() async* {
    try {
      var faultDevices = await repositories.getFaultDeviceFirstPage();
      var runningDevices = await repositories.getRunningDeviceFirstPage();
      yield LoadedDeviceMessageState(
        faultDeviceList: faultDevices,
        runningDeviceList: runningDevices,
        runningListReachMax: false,
        faultListReachMax: false,
      );
    } catch (e) {
      yield LoadErrorDeviceMessageState();
      rethrow;
    }
  }

  Stream<DeviceMessageState> _mapFetchFaultToState() async* {
    try {
      PageDataModel model = await repositories.getFaultDeviceNextPage(
        (state as LoadedDeviceMessageState).faultDeviceList.currentPage +
            1,
      );
      yield model.dataList.isEmpty
          ? (state as LoadedDeviceMessageState)
              .copy(faultListReachMax: true)
          : (state as LoadedDeviceMessageState).copy(
              faultDeviceList: (state as LoadedDeviceMessageState)
                  .faultDeviceList
                  .nextPage(model));
    } catch (e) {
      yield LoadErrorDeviceMessageState();
      rethrow;
    }
  }

  Stream<DeviceMessageState> _mapFetchRunningToState() async* {
    try {
      PageDataModel model = await repositories.getRunningDeviceNextPage(
        (state as LoadedDeviceMessageState)
                .runningDeviceList
                .currentPage +
            1,
      );
      yield model.dataList.isEmpty
          ? (state as LoadedDeviceMessageState)
              .copy(runningListReachMax: true)
          : (state as LoadedDeviceMessageState).copy(
              runningDeviceList: (state as LoadedDeviceMessageState)
                  .runningDeviceList
                  .nextPage(model));
    } catch (e) {
      yield LoadErrorDeviceMessageState();
      rethrow;
    }
  }
}
