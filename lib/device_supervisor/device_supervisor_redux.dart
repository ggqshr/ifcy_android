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
      supervisorMessages:
          supervisiorMessagesReducer(state.supervisorMessages, action),
      departmentMessages:
          departmentMessagesReducer(state.departmentMessages, action),
      taskCycleMessages:
          taskCycleMessagesReducer(state.taskCycleMessages, action),
      taskExecuteList:
          taskExecuteMessagesReducer(state.taskExecuteList, action),
      taskDetailList: taskDetailListMessagesReducer(state.taskDetailList,action),
      offlineDeviceFaultList: offlineDeviceFaultMessagesReducer(
          state.offlineDeviceFaultList, action),
      onlineDeviceFaultSuredList: onlineDeviceFaultSuredMessagesReducer(
          state.onlineDeviceFaultSuredList, action),
      onlineDeviceFaultUnSuredList: onlineDeviceFaultUnSuredMessagesReducer(
          state.onlineDeviceFaultUnSuredList, action),
      processedDeviceFaultList: processedDeviceFaultMessgaesReducer(state.processedDeviceFaultList,action),
      processingDeviceFaultList: processingDeviceFaultMessgaesReducer(state.processingDeviceFaultList,action),
      buildingFloorList: buildingFloorMessgaesReducer(state.buildingFloorList,action),
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

List initsupervisiorMessages(
    List supervisorMessage, InitPageStateAction action) {
  return action.supervisorMessages;
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
  return action.taskExecuteList;
}

Reducer<List> taskExecuteMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskExecuteMessages),
]);

List inittaskDetailListMessages(
    List taskMessageViewListMessage, InitPageStateAction action) {
  return action.taskDetailList;
}

Reducer<List> taskDetailListMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(inittaskDetailListMessages),
]);

///离线设备故障消息列表
List initofflineDeviceFaultMessages(
    List offlineDeviceFaultMessage, InitPageStateAction action) {
  return action.offlineDeviceFaultList;
}

Reducer<List> offlineDeviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initofflineDeviceFaultMessages),
]);

///线上设备已确认故障消息列表
List initonlineDeviceFaultSuredMessages(
    List onlineDeviceFaultSuredMessage, InitPageStateAction action) {
  return action.onlineDeviceFaultSuredList;
}

Reducer<List> onlineDeviceFaultSuredMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initonlineDeviceFaultSuredMessages),
]);

///线上设备待确认故障消息列表
List initonlineDeviceFaultUnSuredMessages(
    List onlineDeviceFaultUnSuredMessage, InitPageStateAction action) {
  return action.onlineDeviceFaultUnSuredList;
}

Reducer<List> onlineDeviceFaultUnSuredMessagesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initonlineDeviceFaultUnSuredMessages),
]);

///处理中设备故障申报消息列表
List initprocessingDeviceFaultMessgaes(
    List processingDeviceFaultMessgae, InitPageStateAction action) {
  return action.processingDeviceFaultList;
}

Reducer<List> processingDeviceFaultMessgaesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initprocessingDeviceFaultMessgaes),
]);

///已处理设备故障申报消息列表
List initprocessedDeviceFaultMessgaes(
    List processedDeviceFaultMessgae, InitPageStateAction action) {
  return action.processedDeviceFaultList;
}

Reducer<List> processedDeviceFaultMessgaesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>(initprocessedDeviceFaultMessgaes),
]);


List initbuildingFloorMessgaes(
    List buildingFloorMessgae, InitPageStateAction action) {
  return action.buildingFloorList;
}

Reducer<List> buildingFloorMessgaesReducer = combineReducers([
  TypedReducer<List, InitPageStateAction>( initbuildingFloorMessgaes),
]);

