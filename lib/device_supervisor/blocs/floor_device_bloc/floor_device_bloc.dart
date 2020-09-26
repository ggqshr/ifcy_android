import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/repositories/repositories.dart';

import './bloc.dart';

class FloorDeviceBloc extends Bloc<FloorDeviceEvent, FloorDeviceState> {
  final FloorMapDataRepositories repositories;
  final String floorId, deviceCode;

  FloorDeviceBloc({this.repositories, this.floorId, this.deviceCode});

  @override
  FloorDeviceState get initialState => LoadingFloorDeviceState();

  @override
  Stream<FloorDeviceState> mapEventToState(
    FloorDeviceEvent event,
  ) async* {
    if (event is LoadFloorDeviceDetailEvent) {
      yield* _mapLoadToState();
    }
  }

  Stream<FloorDeviceState> _mapLoadToState() async* {
    try {
      yield LoadedFloorDeviceState(isLoading: true);
      FloorEntity floor = await repositories.getFloorDetail(floorId);
      FloorDeviceModel device = await repositories.getFloorDevice(deviceCode);
      yield LoadedFloorDeviceState(
          isLoading: false, device: device, currentFloor: floor);
    } catch (e) {
      yield LoadErrorFloorDeviceState();
      rethrow;
    }
  }
}
