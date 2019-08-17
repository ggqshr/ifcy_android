import 'package:ifcy/common/model/model.dart';

import 'action/device_staff_actions.dart';
import 'model/device_staff_model.dart';
import 'package:redux/redux.dart';

DeviceStaffModel deviceStaffModelReducer(DeviceStaffModel state, action) =>
    DeviceStaffModel(
      badgeNumList: badgeNumListReducer(state.badgeNumList, action),
      regularTasks: regularTasksReducer(state.regularTasks, action),
      additionalTasks: additionalTasksReducer(state.additionalTasks, action),
      faultTasks: faultTasksReducer(state.faultTasks, action),
      buildingList: buildingListReducer(state.buildingList, action),
      currentBuilding: currentBuildingReducer(state.currentBuilding, action),
    );

List initBadgeNumList(List _, InitDeviceStaffStateAction action) {
  return action.badgeNumList;
}

Reducer<List> badgeNumListReducer = combineReducers([
  TypedReducer<List, InitDeviceStaffStateAction>(initBadgeNumList),
]);

List initRegularTask(List _, InitDeviceStaffStateAction action) {
  return action.regularTasks;
}

Reducer<List> regularTasksReducer = combineReducers([
  TypedReducer<List, InitDeviceStaffStateAction>(initRegularTask),
]);

List initAdditionalTasks(List _, InitDeviceStaffStateAction action) {
  return action.additionalTasks;
}

Reducer<List> additionalTasksReducer = combineReducers([
  TypedReducer<List, InitDeviceStaffStateAction>(initAdditionalTasks),
]);

List initFaultTasks(List _, InitDeviceStaffStateAction action) {
  return action.faultTasks;
}

Reducer<List> faultTasksReducer = combineReducers([
  TypedReducer<List, InitDeviceStaffStateAction>(initFaultTasks),
]);

Reducer<List> buildingListReducer = combineReducers([
  TypedReducer<List, InitAppBarBuildingList>(
    (_, action) => action.buildingList,
  ),
]);

Reducer<Build> currentBuildingReducer = combineReducers([
  ///初始化建筑物列表
  TypedReducer<Build, InitAppBarBuildingList>(
      (_, action) => action.currentBuilding),

  ///更改当前建筑
  TypedReducer<Build, DeviceStaffChangeBuildAction>(
      (_, action) => action.changedBuilding),
]);
