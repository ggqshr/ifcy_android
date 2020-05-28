import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/repositories/device_check_repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import './bloc.dart';

class DeviceStaffDeviceCheckBloc
    extends Bloc<DeviceStaffDeviceCheckEvent, DeviceStaffDeviceCheckState> {
  final DeviceCheckRepositories _repositories;
  final UserLoginRepositories userLoginRepositories;
  StreamSubscription _subscription;

  DeviceStaffDeviceCheckBloc(this._repositories,this.userLoginRepositories);

  @override
  DeviceStaffDeviceCheckState get initialState => DeviceListLoading();

  @override
  Stream<DeviceStaffDeviceCheckState> mapEventToState(
    DeviceStaffDeviceCheckEvent event,
  ) async* {
    if (event is LoadDevice) {
      yield* _mapLoadDeviceToState(event);
    }
    if (event is UpdateDevice) {
      yield* _mapUpdateToState(event);
    }
    if (event is DeviceUpdate) {
      yield* _mapDeviceUpdateToState(event);
    }
  }

  Stream<DeviceStaffDeviceCheckState> _mapLoadDeviceToState(
      LoadDevice event) async* {
    _subscription?.cancel();
    _subscription = _repositories.deviceList.listen((device) {
      add(DeviceUpdate(device));
    });
    if (state is DeviceListLoading) {
      try {
        _repositories.updateLocal(event.models);
      } catch (e) {
        yield DeviceListNotLoad();
        rethrow;
      }
    }
  }

  Stream<DeviceStaffDeviceCheckState> _mapUpdateToState(
      UpdateDevice event) async* {
    try {
      _repositories.updateDevice(event.model);
    } catch (e) {
      rethrow;
    }
  }

  Stream<DeviceStaffDeviceCheckState> _mapDeviceUpdateToState(
      DeviceUpdate event) async* {
    List<FloorEntity> floorList = [];
    Set<String> floorIdList =
    event.models.map((item) => item.buildingFloorId).toSet();
    floorList = userLoginRepositories
        .currentBuild
        .floors
        .where((item) => floorIdList.contains(item.id))
        .toList();
    yield DeviceListLoaded(event.models, floorList);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.close();
  }
}
