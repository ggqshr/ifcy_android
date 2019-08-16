import 'package:ifcy/common/model/model.dart';
import 'package:redux/redux.dart';

import 'actions/device_supervisor_actions.dart';
import 'model/device_supervisor_model.dart';

DeviceSupervisorModel deviceSupervisorModule1Reducer(
        DeviceSupervisorModel state, action) =>
    DeviceSupervisorModel(
      faultNum: faultNumReducer(state.faultNum, action),
      taskRate: taskRateReducer(state.taskRate, action),
      buildingList: buildingListReducer(state.buildingList, action),
      currentBuilding: currentBuildingReducer(state.currentBuilding, action),
      bottomBadgeNumList:
          bottomBadgeNumListReducer(state.bottomBadgeNumList, action),
      fireAlarmMessages:
          fireAlarmMessagesReducer(state.fireAlarmMessages, action),
      deviceFaultMessages:
          deviceFaultMessagesReducer(state.deviceFaultMessages, action),
      taskInfoMessages: taskInfoMessagesReducer(state.taskInfoMessages, action),
    );

int initFaultNum(int faultNum, InitDeviceSupervisorStateAction action) {
  return action.faultNum;
}

Reducer<int> faultNumReducer = combineReducers([
  TypedReducer<int, InitDeviceSupervisorStateAction>(initFaultNum),
]);

int initTaskRate(int taskRate, InitDeviceSupervisorStateAction action) {
  return action.taskRate;
}

Reducer<int> taskRateReducer = combineReducers([
  TypedReducer<int, InitDeviceSupervisorStateAction>(initTaskRate),
]);

List initBuildingList(List buildingList, DeviceSupervisorInitBuildingList action) {
  return action.buildingList;
}

Reducer<List> buildingListReducer = combineReducers([
  TypedReducer<List, DeviceSupervisorInitBuildingList>(initBuildingList),
]);

Build initCurrentBuilding(Build currentBuilding, DeviceSupervisorInitBuildingList action) {
  return action.currentBuilding;
}

Build changeBuilding(Build building, DeviceSupervisorOnChangeBuilding action) {
  return action.building;
}

Reducer<Build> currentBuildingReducer = combineReducers([
  TypedReducer<Build, DeviceSupervisorInitBuildingList>(initCurrentBuilding),
  TypedReducer<Build, DeviceSupervisorOnChangeBuilding>(changeBuilding),
]);

List initBottomBadgeNumList(
    List bottomBadgeNumList, InitDeviceSupervisorStateAction action) {
  return action.bottomBadgeNumList;
}

Reducer<List> bottomBadgeNumListReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initBottomBadgeNumList),
]);

List initFireMessage(List fireMessages, InitDeviceSupervisorStateAction action) {
  return action.fireMessage;
}

Reducer<List> fireAlarmMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initFireMessage),
]);

List initdeviceFaultMessage(List deviceMessages, InitDeviceSupervisorStateAction action) {
  return action.deviceFaultMessage;
}

Reducer<List> deviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initdeviceFaultMessage),
]);

List inittaskInfoMessages(List taskInfoMessages, InitDeviceSupervisorStateAction action) {
  return action.taskInfoMessage;
}

Reducer<List> taskInfoMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(inittaskInfoMessages),
]);
