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
      supervisorMessages:
          supervisiorMessagesReducer(state.supervisorMessages, action),
      departmentMessages:
          departmentMessagesReducer(state.departmentMessages, action),
      taskCycleMessages:
          taskCycleMessagesReducer(state.taskCycleMessages, action),
      taskExecuteModel:
          taskExecuteMessagesReducer(state.taskExecuteModel, action),
      taskMessageViewList:
        taskMessageViewListMessagesReducer(state.taskMessageViewList,action),
      offlineDeviceFaultList:
        offlineDeviceFaultMessagesReducer(state.offlineDeviceFaultList,action),
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

List initdeviceFaultMessage(List deviceMessages, InitPageStateAction action) {
  return action.deviceFaultMessage;
}

Reducer<List> deviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initdeviceFaultMessage),
]);

List inittaskInfoMessages(List taskInfoMessages, InitPageStateAction action) {
  return action.taskInfoMessage;
}

Reducer<List> taskInfoMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskInfoMessages),
]);

List initsupervisiorMessages(
    List supervisorMessage, InitPageStateAction action) {
  return action.supervisorMessgae;
}

Reducer<List> supervisiorMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initsupervisiorMessages),
]);

List initdepartmentMessages(
    List departmentMessage, InitPageStateAction action) {
  return action.departmentMessage;
}

Reducer<List> departmentMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initdepartmentMessages),
]);

/// 初始化任务类型信息
List inittaskCycleMessages(List taskCycleMessage, InitPageStateAction action) {
  return action.taskCycleMessages;
}

Reducer<List> taskCycleMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskCycleMessages),
]);

List inittaskExecuteMessages(
    List taskExecuteMessage, InitPageStateAction action) {
  return action.taskExecuteModel;
}

Reducer<List> taskExecuteMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskExecuteMessages),
]);

List inittaskMessageViewListMessages(
    List taskMessageViewListMessage, InitPageStateAction action) {
  return action.taskMessageViewList;
}

Reducer<List> taskMessageViewListMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskMessageViewListMessages),
]);

///离线设备故障消息列表
List initofflineDeviceFaultMessages(
    List offlineDeviceFaultMessage, InitPageStateAction action) {
    return action.offlineDeviceFaultList;
}

Reducer<List> offlineDeviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initofflineDeviceFaultMessages),
]);

