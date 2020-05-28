import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_staff/repositories/floor_map_repositories.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import './bloc.dart';

class FloorMapBloc extends Bloc<FloorMapEvent, FloorMapState> {
  final FloorMapDataRepositories repositories;
  final List<InspectionDeviceModel> devices;
  final UserLoginRepositories userLoginRepositories;

  FloorMapBloc(this.repositories, this.userLoginRepositories, this.devices);

  @override
  FloorMapState get initialState => LoadingFloorMapState();

  @override
  Stream<FloorMapState> mapEventToState(
    FloorMapEvent event,
  ) async* {
    if (event is LoadFloorDetailEvent) {
      final allFloors = userLoginRepositories.currentBuild.floors;
      final allFloorID = devices.map((item) => item.buildingFloorId).toSet();
      yield LoadedFloorMapState(
        devices: devices,
        floors:
            allFloors.where((item) => allFloorID.contains(item.id)).toList(),
        currentFloor: null,
        isLoading: false,
      );
    }
    if (event is ChangeFloorEvent) {
      yield* _mapChangeToState(event);
    }
  }

  Stream<FloorMapState> _mapChangeToState(ChangeFloorEvent event) async* {
    try {
      yield (state as LoadedFloorMapState).copyWith(isLoading: true);
      final floor = await repositories.getFloorDetail(event.floorId);
      yield (state as LoadedFloorMapState)
          .copyWith(isLoading: false, currentFloor: floor);
    } catch (e) {
      yield LoadErrorFloorMapState();
      rethrow;
    }
  }
}
