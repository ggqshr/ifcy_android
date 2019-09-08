import 'package:redux/redux.dart';
import 'package:ifcy/common/model/model.dart';

import 'action/building_owner_actions.dart';
import 'model/building_owner_model.dart';

BuildingOwnerModel buildingOwnerModelReducer(BuildingOwnerModel state,action)=>
    BuildingOwnerModel(
      buildingList: ownerBuildingListReducer(state.buildingList, action),
      currentBuilding: currentBuildingReducer(state.currentBuilding, action),
      faultNum: ownerHomePageFaultNumReducer(state.faultNum,action),
      fireNum: ownerHomePageFireNumReducer(state.fireNum,action),
      taskProgress: ownerHomePageFireNumReducer(state.taskProgress,action),
      fireAlarmMessages: ownerHomePageFireAlarmMessagesReducer(state.fireAlarmMessages,action),
      deviceFaultMessages: ownerHomePageDeviceFaultMessagesReducer(state.deviceFaultMessages,action),
      processedDeviceFaultList: declarePageDeviceFaultDeclareMessagesReducer(state.processedDeviceFaultList,action),
      projectStaffList: projectStaffMessageReducer(state.projectStaffList,action),
    );


Reducer<Build> currentBuildingReducer = combineReducers([
  ///初始化当前所在大厦
  TypedReducer<Build, InitOwnerPageAppBarBuildingList>(
          (_, action) => action.currentBuilding),

  ///更改当前大厦
  TypedReducer<Build, BuildingOwnerChangeBuildAction >(
          (_, action) => action.changedBuilding),
]);

///初始化大厦列表
Reducer<List> ownerBuildingListReducer = combineReducers([
  TypedReducer<List, InitOwnerPageAppBarBuildingList>(
        (_, action) => action.buildingList,
  ),
]);

///初始化设备故障数
int initOwnerHomePageFaultNum(int faultNum, InitOwnerPageStateAction action) {
  return action.faultNum;
}
Reducer<int>  ownerHomePageFaultNumReducer = combineReducers([
  TypedReducer<int, InitOwnerPageStateAction>(initOwnerHomePageFaultNum),
]);

///初始化火警警报数
int initOwnerHomePageFireNum(int faultNum, InitOwnerPageStateAction action) {
  return action.fireNum;
}
Reducer<int> ownerHomePageFireNumReducer = combineReducers([
  TypedReducer<int, InitOwnerPageStateAction>(initOwnerHomePageFireNum),
]);

///初始化任务进度
int initOwnerHomePageTaskProgress(int taskRate, InitOwnerPageStateAction action) {
  return action.taskProgress;
}
Reducer<int> ownerHomePageTaskProgressReducer = combineReducers([
  TypedReducer<int, InitOwnerPageStateAction>(initOwnerHomePageTaskProgress),
]);
///初始化火警消息
List initOwnerHomePageFireMessage(List fireMessages, InitOwnerPageStateAction action) {
  return action.fireAlarmMessages;
}
Reducer<List> ownerHomePageFireAlarmMessagesReducer = combineReducers([
  TypedReducer<List, InitOwnerPageStateAction>(initOwnerHomePageFireMessage),
]);

///初始化故障消息
List initOwnerHomePageDeviceFaultMessage(List deviceMessages, InitOwnerPageStateAction action) {
  return action.deviceFaultMessages;
}
Reducer<List> ownerHomePageDeviceFaultMessagesReducer = combineReducers([
  TypedReducer<List, InitOwnerPageStateAction>(initOwnerHomePageDeviceFaultMessage),
]);

///初始化设备故障申报
List initDeclarePageDeviceFaultDeclareMessage(List deviceFalutDeclareMessages, InitOwnerPageStateAction action) {
  return action.processedDeviceFaultList;
}
Reducer<List> declarePageDeviceFaultDeclareMessagesReducer = combineReducers([
  TypedReducer<List, InitOwnerPageStateAction>(initDeclarePageDeviceFaultDeclareMessage),
]);

///初始化项目人员列表
List initProjectStaffMessage(List projectStaffMessages, InitOwnerPageStateAction action) {
  return action.projectStaffList;
}
Reducer<List> projectStaffMessageReducer = combineReducers([
  TypedReducer<List, InitOwnerPageStateAction>(initProjectStaffMessage),
]);