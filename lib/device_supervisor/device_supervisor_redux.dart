import 'package:redux/redux.dart';

import 'actions/device_supervisor_actions.dart';
import 'model/device_supervisor_model.dart';

DeviceSupervisorModel deviceSupervisorMoudle1Reducer(
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
    );

int initFaultNum(int faultNum, InitPageStateAction action) {
  return action.faultNum;
}

Reducer<int> faultNumReducer = combineReducers([
  TypedReducer<int, InitPageStateAction>(initFaultNum),
]);

int initTaskRate(int taskRate, InitPageStateAction action) {
  return action.taskRate;
}

Reducer<int> taskRateReducer = combineReducers([
  TypedReducer<int, InitPageStateAction>(initTaskRate),
]);

List initBuildingList(List buildingList, InitPageStateAction action) {
  return action.buildingList;
}

Reducer<List> buildingListReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initBuildingList),
]);

String initCurrentBuilding(String currentBuilding, InitPageStateAction action) {
  return action.currentBuilding;
}

String changeBuilding(String building, OnChangeBuilding action) {
  return action.buildingName;
}

Reducer<String> currentBuildingReducer = combineReducers([
  TypedReducer<String, InitPageStateAction>(initCurrentBuilding),
  TypedReducer<String, OnChangeBuilding>(changeBuilding),
]);

List initBottomBadgeNumList(
    List bottomBadgeNumList, InitPageStateAction action) {
  return action.bottomBadgeNumList;
}

Reducer<List> bottomBadgeNumListReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initBottomBadgeNumList),
]);

List initFireMessage(List fireMessages, InitPageStateAction action) {
  return action.fireMessage;
}

Reducer<List> fireAlarmMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initFireMessage),
]);
