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
    if (event is FilterCheckAlarmData) {
      yield* _mapFirstFilterToState(event);
    }
    if (event is ContinueFilterCheckAlarmData) {
      yield* _mapExistedFilterToState(event);
    }
    if (event is RefreshFilterCheckAlarmData) {
      yield* _mapRefreshFilterToState(event);
    }
    if (event is UpdateFindingDateFilter) {
      yield* _mapUpdateFilterToState(event);
    }
    if (event is ResetCheckAlarmListState) {
      yield* _mapResetState(event);
    }
    if (event is RefreshTrueAlarmData) {
      yield* _mapRefreshTrueToState();
    }
    if (event is FetchTrueAlarmData) {
      yield* _mapFetchTrueToState();
    }
  }

  Stream<CheckAlarmListState> _mapRefreshTrueToState() async* {
    PageDataModel model;
    try {
      model = await _repositories.getTrueAlarmMassageFirstPage();
      yield LoadedCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapFetchTrueToState() async* {
    PageDataModel model;
    try {
      if (state is LoadingCheckAlarmState) {
        model = await _repositories.getTrueAlarmMassageFirstPage();
        yield LoadedCheckAlarmState(model: model, isReachMax: false);
      } else if (state is LoadedCheckAlarmState) {
        var current = (state as LoadedCheckAlarmState).model;
        model = await _repositories
            .getTrueAlarmMassageNextPage(current.currentPage + 1);
        yield model.dataList.isEmpty
            ? LoadedCheckAlarmState(model: current, isReachMax: true)
            : LoadedCheckAlarmState(
                model: current.nextPage(model), isReachMax: false);
      }
    } catch (e) {
      yield LoadErrorCheckAlarmState();
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

  Stream<CheckAlarmListState> _mapRefreshFilterToState(
      RefreshFilterCheckAlarmData event) async* {
    PageDataModel model;
    try {
//      model = await _repositories.getFireFirstPage();
      model = await _repositories.filterFireFirstPage(event.findingDate);
      yield FilteringCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapFirstFilterToState(
      FilterCheckAlarmData event) async*{
    PageDataModel model;
    try {
//      model = await _repositories.getFireFirstPage();
      model = await _repositories.filterFireFirstPage(event.findingDate);
      yield FilteringCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapExistedFilterToState(
      ContinueFilterCheckAlarmData event) async*{
    PageDataModel model;
    try {
      var current = (state as FilteringCheckAlarmState).model;
      model = await _repositories.filterFireNextPage(event.findingDate,current.currentPage + 1);
//      model = await _repositories.getFireNextPage(current.currentPage + 1);
      yield model.dataList.isEmpty
          ? FilteringCheckAlarmState(model: current, isReachMax: true)
          : FilteringCheckAlarmState(
          model: current.nextPage(model), isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapUpdateFilterToState(
      UpdateFindingDateFilter event) async*{
    PageDataModel model;
    try {
      model = await _repositories.getFireFirstPage();
//      model = await _repositories.filterFireFirstPage(event.findingDate);
      yield FilteringCheckAlarmState(model: model, isReachMax: true, date:event.findingDate);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapResetState(
      ResetCheckAlarmListState event) async*{
    PageDataModel model;
    try {
      model = await _repositories.getFireFirstPage();
      yield LoadedCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }
}
