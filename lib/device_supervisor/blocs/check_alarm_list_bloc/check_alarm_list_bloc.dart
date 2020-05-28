import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import './bloc.dart';

class CheckAlarmListBloc
    extends Bloc<CheckAlarmListEvent, CheckAlarmListState> {
  final CheckAlarmRepositories _repositories;

  CheckAlarmListBloc(this._repositories);

  @override
  CheckAlarmListState get initialState => LoadingCheckAlarmState();

  @override
  Stream<CheckAlarmListState> mapEventToState(
    CheckAlarmListEvent event,
  ) async* {
    if (event is FetchCheckedAlarmData) {
      yield* _mapFetchToState(event);
    }
    if (event is RefreshCheckAlarmData) {
      yield* _mapRefreshToState(event);
    }
  }

  Stream<CheckAlarmListState> _mapFetchToState(
      FetchCheckedAlarmData event) async* {
    PageDataModel model;
    try {
      if (state is LoadingCheckAlarmState) {
        if (event.isFire) {
          model = await _repositories.getFireFirstPage();
        } else {
          model = await _repositories.getDeviceFirstPage();
        }
        yield LoadedCheckAlarmState(model: model, isReachMax: false);
      } else if (state is LoadedCheckAlarmState) {
        if (event.isFire) {
          var current = (state as LoadedCheckAlarmState).model;
          model = await _repositories.getFireNextPage(current.currentPage + 1);
          yield model.dataList.isEmpty
              ? LoadedCheckAlarmState(model: current, isReachMax: true)
              : LoadedCheckAlarmState(
                  model: current.nextPage(model), isReachMax: false);
        } else {
          var current = (state as LoadedCheckAlarmState).model;
          model =
              await _repositories.getDeviceNextPage(current.currentPage + 1);
          yield model.dataList.isEmpty
              ? LoadedCheckAlarmState(model: current, isReachMax: true)
              : LoadedCheckAlarmState(
                  model: current.nextPage(model), isReachMax: false);
        }
      }
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapRefreshToState(
      RefreshCheckAlarmData event) async* {
    PageDataModel model;
    try {
      if (event.isFire) {
        model = await _repositories.getFireFirstPage();
      } else {
        model = await _repositories.getDeviceFirstPage();
      }
      yield LoadedCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }
}
