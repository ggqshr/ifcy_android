import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import './bloc.dart';

class DeviceDetailBloc extends Bloc<DeviceDetailEvent, DeviceDetailState> {
  DeviceStaffDeviceCheckBloc _bloc;

  DeviceDetailBloc([this._bloc]);

  @override
  DeviceDetailState get initialState => LoadingDetail();

  @override
  Stream<DeviceDetailState> mapEventToState(
    DeviceDetailEvent event,
  ) async* {
    if (event is LoadData) {
      yield LoadedDetail(
        model: event.model,
        floorList: (_bloc.currentState as DeviceListLoaded).floorList,
      );
    }
    if (event is UpdateCheckResult) {
      yield LoadedDetail(
        model: (currentState as LoadedDetail)
            .model
            .copy(checkResult: event.checkResult),
        floorList: (currentState as LoadedDetail).floorList,
      );
    }
    if (event is UpdateComment) {
      yield LoadedDetail(
        model:
            (currentState as LoadedDetail).model.copy(comment: event.comment),
        floorList: (currentState as LoadedDetail).floorList,
      );
    }
    if (event is UpdateImages) {
      if (event.index == 0) {
        yield LoadedDetail(
          model: (currentState as LoadedDetail)
              .model
              .copy(pic1: event.imageAName, index: event.index),
          floorList: (currentState as LoadedDetail).floorList,
        );
      }
      if (event.index == 1) {
        yield LoadedDetail(
          model: (currentState as LoadedDetail)
              .model
              .copy(pic2: event.imageAName, index: event.index),
          floorList: (currentState as LoadedDetail).floorList,
        );
      }
    }
    if (event is UpdateLocal) {
      _bloc.dispatch(UpdateDevice((currentState as LoadedDetail).model));
    }
  }
}
