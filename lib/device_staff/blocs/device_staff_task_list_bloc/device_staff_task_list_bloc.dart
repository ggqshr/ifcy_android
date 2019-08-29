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
    try {
      if (event is FetchAll &&
          currentState is UnInitialDeviceStaffTaskListState) {
        yield* _mapFetchAllToState();
        return;
      }
      if (event is FetchComplete) {
        yield* _mapFetchCompleteToState();
        return;
      }
      if (event is FetchUnComplete) {
        yield* _mapFetchUnCompleteToState();
        return;
      }
      if (event is RefreshComplete) {
        final model = await repositories.getFirstPageComplete();
        yield (currentState as LoadedDeviceStaffTaskListState)
            .copy(completeIsReachMax: false, completeTask: model);
        return;
      }
      if (event is RefreshUnComplete) {
        final model = await repositories.getFirstPageUnComplete();
        yield (currentState as LoadedDeviceStaffTaskListState)
            .copy(unCompleteIsReachMax: false, unCompleteTask: model);
        return;
      }
    } catch (e) {
      yield LoadErrorDeviceStaffTaskList();
      rethrow;
    }
  }

  Stream<DeviceStaffTaskListState> _mapFetchCompleteToState() async* {
    InspectionTaskPageModel model = await repositories.getNextPageComplete(
        (currentState as LoadedDeviceStaffTaskListState)
                .completeTask
                .currentPageNum +
            1);
    yield model.taskInfoList.isEmpty
        ? (currentState as LoadedDeviceStaffTaskListState)
            .copy(completeIsReachMax: true)
        : (currentState as LoadedDeviceStaffTaskListState).copy(
            completeTask: (currentState as LoadedDeviceStaffTaskListState)
                .completeTask
                .nextPage(model),
          );
  }

  Stream<DeviceStaffTaskListState> _mapFetchUnCompleteToState() async* {
    InspectionTaskPageModel model = await repositories.getNextPageUnComplete(
        (currentState as LoadedDeviceStaffTaskListState)
                .unCompleteTask
                .currentPageNum +
            1);

    yield model.taskInfoList.isEmpty
        ? (currentState as LoadedDeviceStaffTaskListState)
            .copy(unCompleteIsReachMax: true)
        : (currentState as LoadedDeviceStaffTaskListState).copy(
            unCompleteTask: (currentState as LoadedDeviceStaffTaskListState)
                .unCompleteTask
                .nextPage(model),
          );
  }

  Stream<DeviceStaffTaskListState> _mapFetchAllToState() async* {
    yield LoadedDeviceStaffTaskListState(
      completeTask: await repositories.getFirstPageComplete(),
      unCompleteTask: await repositories.getFirstPageUnComplete(),
      completeIsReachMax: false,
      unCompleteIsReachMax: false,
    );
  }
}
