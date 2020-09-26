import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_staff/repositories/repositories.dart';

import './bloc.dart';

class DeviceStaffTaskListBloc
    extends Bloc<DeviceStaffTaskListEvent, DeviceStaffTaskListState> {
  DeviceStaffTaskListRepositories repositories;

  DeviceStaffTaskListBloc([repo])
      : repositories = repo ?? DeviceStaffTaskListRepositories();

  @override
  DeviceStaffTaskListState get initialState =>
      UnInitialDeviceStaffTaskListState();

  @override
  Stream<DeviceStaffTaskListState> mapEventToState(
    DeviceStaffTaskListEvent event,
  ) async* {
    if (event is FetchAll &&
        (state is UnInitialDeviceStaffTaskListState||state is LoadErrorDeviceStaffTaskList)) {
      yield* _mapFetchAllToState();
    }
    if (event is FetchComplete) {
      yield* _mapFetchCompleteToState();
    }
    if (event is FetchUnComplete) {
      yield* _mapFetchUnCompleteToState();
    }
    try {
      if (event is RefreshComplete) {
        final model = await repositories.getFirstPageComplete();
        yield (state as LoadedDeviceStaffTaskListState)
            .copy(completeIsReachMax: false, completeTask: model);
      }
      if (event is RefreshUnComplete) {
        final model = await repositories.getFirstPageUnComplete();
        yield (state as LoadedDeviceStaffTaskListState)
            .copy(unCompleteIsReachMax: false, unCompleteTask: model);
      }
    } catch (e) {
      yield LoadErrorDeviceStaffTaskList();
      rethrow;
    }
  }

  Stream<DeviceStaffTaskListState> _mapFetchCompleteToState() async* {
    try{
      InspectionTaskPageModel model = await repositories.getNextPageComplete(
          (state as LoadedDeviceStaffTaskListState)
              .completeTask
              .currentPageNum +
              1);
      yield model.taskInfoList.isEmpty
          ? (state as LoadedDeviceStaffTaskListState)
          .copy(completeIsReachMax: true)
          : (state as LoadedDeviceStaffTaskListState).copy(
        completeTask: (state as LoadedDeviceStaffTaskListState)
            .completeTask
            .nextPage(model),
      );
    }catch(e){
      yield LoadErrorDeviceStaffTaskList();
      rethrow;
    }
  }

  Stream<DeviceStaffTaskListState> _mapFetchUnCompleteToState() async* {
    try{
      InspectionTaskPageModel model = await repositories.getNextPageUnComplete(
          (state as LoadedDeviceStaffTaskListState)
              .unCompleteTask
              .currentPageNum +
              1);

      yield model.taskInfoList.isEmpty
          ? (state as LoadedDeviceStaffTaskListState)
          .copy(unCompleteIsReachMax: true)
          : (state as LoadedDeviceStaffTaskListState).copy(
        unCompleteTask: (state as LoadedDeviceStaffTaskListState)
            .unCompleteTask
            .nextPage(model),
      );
    }catch(e){
      yield LoadErrorDeviceStaffTaskList();
      rethrow;
    }
  }

  Stream<DeviceStaffTaskListState> _mapFetchAllToState() async* {
    try{
      var completeTasks = await repositories.getFirstPageComplete();
      var unCompleteTask = await repositories.getFirstPageUnComplete();
      yield LoadedDeviceStaffTaskListState(
        completeTask: completeTasks,
        unCompleteTask: unCompleteTask,
        completeIsReachMax: false,
        unCompleteIsReachMax: false,
      );
    }catch(e){
      yield LoadErrorDeviceStaffTaskList();
      rethrow;
    }
  }
}
