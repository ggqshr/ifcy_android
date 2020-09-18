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
    if (event is UpdateAlarmByDate) {
      yield* _mapFilterToState(event);
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

  Stream<CheckAlarmListState> _mapFilterToState(
      UpdateAlarmByDate event) async*{
    PageDataModel model;
    PageDataModel tempModel;
    try {
      model = await _repositories.getFireFirstPage();
      tempModel = await _repositories.getFireFirstPage();
      String before,after;
      int offset = 0;
      for(int i=0;i<tempModel.dataList.length;i++){
        before = tempModel.dataList[i].recordTime.toString();
        after = event.findingDate.toString().substring(0,10);
        if(!before.contains(after)){
          model.dataList.removeAt(i-offset);
          offset++;
        }
      }
      yield LoadedCheckAlarmState(model: model, isReachMax: false);
    } catch (e) {
      yield LoadErrorCheckAlarmState();
    }
  }

  Stream<CheckAlarmListState> _mapRefreshToState(
      RefreshCheckAlarmData event) async* {
    if(state is FilteringCheckAlarmState){
      PageDataModel model;
      try{

        yield LoadedCheckAlarmState(model: model, isReachMax: false);
      }catch (e) {
        yield LoadErrorCheckAlarmState();
      }
    }else{
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
}
