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
      taskInfoMessages: taskInfoMessagesReducer(state.taskInfoMessages, action),
      supervisorMessages:
          supervisiorMessagesReducer(state.supervisorMessages, action),
      departmentMessages:
          departmentMessagesReducer(state.departmentMessages, action),
      taskCycleMessages:
          taskCycleMessagesReducer(state.taskCycleMessages, action),
      taskExecuteList:
          taskExecuteMessagesReducer(state.taskExecuteList, action),
      taskDetailList:
          taskDetailListMessagesReducer(state.taskDetailList, action),
      offlineDeviceFaultList: offlineDeviceFaultMessagesReducer(
          state.offlineDeviceFaultList, action),
      onlineDeviceFaultSuredList: onlineDeviceFaultSuredMessagesReducer(
          state.onlineDeviceFaultSuredList, action),
      onlineDeviceFaultUnSuredList: onlineDeviceFaultUnSuredMessagesReducer(
          state.onlineDeviceFaultUnSuredList, action),
      processedDeviceFaultList: processedDeviceFaultMessgaesReducer(
          state.processedDeviceFaultList, action),
      processingDeviceFaultList: processingDeviceFaultMessgaesReducer(
          state.processingDeviceFaultList, action),
      buildingFloorList:
          buildingFloorMessgaesReducer(state.buildingFloorList, action),
      inspectionSystems:
          inspectionSystemsReducer(state.inspectionSystems, action),
      planPageModel: planPageModelReducer(state.planPageModel, action),
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

List initBuildingList(
    List buildingList, DeviceSupervisorInitBuildingList action) {
  return action.buildingList;
}

Reducer<List> buildingListReducer = combineReducers([
  TypedReducer<List, DeviceSupervisorInitBuildingList>(initBuildingList),
  TypedReducer<List, AddTaskPageInitAction>((_, action) => action.buildingList),
]);

Build initCurrentBuilding(
    Build currentBuilding, DeviceSupervisorInitBuildingList action) {
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

List initFireMessage(
    List fireMessages, InitDeviceSupervisorStateAction action) {
  return action.fireMessage;
}

Reducer<List> fireAlarmMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initFireMessage),
]);


List inittaskInfoMessages(
    List taskInfoMessages, InitDeviceSupervisorStateAction action) {
  return action.taskInfoMessage;
}

Reducer<List> taskInfoMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(inittaskInfoMessages),
]);

List initsupervisiorMessages(
    List supervisorMessage, InitDeviceSupervisorStateAction action) {
  return action.supervisorMessages;
}

Reducer<List> supervisiorMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initsupervisiorMessages),
]);

List initdepartmentMessages(
    List departmentMessage, InitDeviceSupervisorStateAction action) {
  return action.departmentMessage;
}

Reducer<List> departmentMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(initdepartmentMessages),
  TypedReducer<List, AddTaskPageInitAction>((_, action) => action.departments),
]);

/// 初始化任务类型信息
List inittaskCycleMessages(
    List taskCycleMessage, InitDeviceSupervisorStateAction action) {
  return action.taskCycleMessages;
}

Reducer<List> taskCycleMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(inittaskCycleMessages),
]);

List inittaskExecuteMessages(
    List taskExecuteMessage, InitDeviceSupervisorStateAction action) {
  return action.taskExecuteList;
}

Reducer<List> taskExecuteMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(inittaskExecuteMessages),
]);

List inittaskDetailListMessages(
    List taskMessageViewListMessage, InitDeviceSupervisorStateAction action) {
  return action.taskDetailList;
}

Reducer<List> taskDetailListMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      inittaskDetailListMessages),
]);

///离线设备故障消息列表
List initofflineDeviceFaultMessages(
    List offlineDeviceFaultMessage, InitDeviceSupervisorStateAction action) {
  return action.offlineDeviceFaultList;
}

Reducer<List> offlineDeviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initofflineDeviceFaultMessages),
]);

///线上设备已确认故障消息列表
List initonlineDeviceFaultSuredMessages(List onlineDeviceFaultSuredMessage,
    InitDeviceSupervisorStateAction action) {
  return action.onlineDeviceFaultSuredList;
}

Reducer<List> onlineDeviceFaultSuredMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initonlineDeviceFaultSuredMessages),
]);

///线上设备待确认故障消息列表
List initonlineDeviceFaultUnSuredMessages(List onlineDeviceFaultUnSuredMessage,
    InitDeviceSupervisorStateAction action) {
  return action.onlineDeviceFaultUnSuredList;
}

Reducer<List> onlineDeviceFaultUnSuredMessagesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initonlineDeviceFaultUnSuredMessages),
]);

///处理中设备故障申报消息列表
List initprocessingDeviceFaultMessgaes(
    List processingDeviceFaultMessgae, InitDeviceSupervisorStateAction action) {
  return action.processingDeviceFaultList;
}

Reducer<List> processingDeviceFaultMessgaesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initprocessingDeviceFaultMessgaes),
]);

///已处理设备故障申报消息列表
List initprocessedDeviceFaultMessgaes(
    List processedDeviceFaultMessgae, InitDeviceSupervisorStateAction action) {
  return action.processedDeviceFaultList;
}

Reducer<List> processedDeviceFaultMessgaesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initprocessedDeviceFaultMessgaes),
]);

List initbuildingFloorMessgaes(
    List buildingFloorMessgae, InitDeviceSupervisorStateAction action) {
  return action.buildingFloorList;
}

Reducer<List> buildingFloorMessgaesReducer = combineReducers([
  TypedReducer<List, InitDeviceSupervisorStateAction>(
      initbuildingFloorMessgaes),
]);

Reducer<List> inspectionSystemsReducer = combineReducers([
  TypedReducer<List, AddTaskPageInitAction>((_, action) => action.systems),
]);

PlanTaskListPageModel nextPageCall(
    PlanTaskListPageModel model, DeviceSuperVisorNextPageAction action) {
  model.currentPageNum += 1;
  model.planLists.addAll(action.model.planLists);
  return model;
}

Reducer<PlanTaskListPageModel> planPageModelReducer = combineReducers([
  TypedReducer<PlanTaskListPageModel, InitPlanListPageAction>(
      (_, action) => action.model),
  TypedReducer<PlanTaskListPageModel, DeviceSuperVisorNextPageAction>(nextPageCall),
]);
