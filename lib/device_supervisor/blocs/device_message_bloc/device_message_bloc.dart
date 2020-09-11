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
    if (event is FetchAllDevices) {
      yield* _mapFetchAllToState();
    }
    if (event is FetchFaultDevices) {
      yield* _mapFetchFaultToState();
    }
    if (event is FetchRunningDevices) {
      yield* _mapFetchRunningToState();
    }
    if (event is ChangeShowStatusDevice) {
      yield* _mapChangeShowStatusToState(event);
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

  Stream<DeviceMessageState> _mapChangeShowStatusToState(
      ChangeShowStatusDevice event) async* {
    String id = event.messageId;
    String messageType = event.deviceType;

    if (messageType == "RUNNING") {
      var runningDevices =
          (state as LoadedDeviceMessageState).runningDeviceList;
      List<DeviceMessage> dataList = name(runningDevices, id);
      var newState = (state as LoadedDeviceMessageState)
          .copy(runningDeviceList: runningDevices.copyWith(dataList: dataList));
      yield newState;
    } else {
      var faultDevices = (state as LoadedDeviceMessageState).faultDeviceList;
      List<DeviceMessage> dataList = name(faultDevices, id);
      var newState = (state as LoadedDeviceMessageState)
          .copy(faultDeviceList: faultDevices.copyWith(dataList: dataList));
      yield newState;
    }
  }

  List<DeviceMessage> name(PageDataModel deviceList, String id) {
    var dataListOld = deviceList.dataList;
    List<DeviceMessage> dataList = List.generate(
        dataListOld.length, (index) => dataListOld[index]);
    int this_index = dataList.indexWhere((item) => item.id == id);
    dataList[this_index] = dataList[this_index]
        .copyWith(showDetail: !dataList[this_index].showDetail);
    return dataList;
  }

  Stream<DeviceMessageState> _mapFetchAllToState() async* {
    try {
      yield LoadingDeviceMessageState();
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
        (state as LoadedDeviceMessageState).faultDeviceList.currentPage + 1,
      );
      yield model.dataList.isEmpty
          ? (state as LoadedDeviceMessageState).copy(faultListReachMax: true)
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
        (state as LoadedDeviceMessageState).runningDeviceList.currentPage + 1,
      );
      yield model.dataList.isEmpty
          ? (state as LoadedDeviceMessageState).copy(runningListReachMax: true)
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
