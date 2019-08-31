import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import '../device_staff_blocs.dart';
import '../device_staff_blocs.dart';
import './bloc.dart';

class DeviceListFilterBloc
    extends Bloc<DeviceListFilterEvent, DeviceListFilterState> {
  final DeviceStaffDeviceCheckBloc bloc;
  StreamSubscription todoSubscription;

  DeviceListFilterBloc(this.bloc) {
    todoSubscription = bloc.state.listen((st) {
      if (st is DeviceListLoaded) {
        dispatch(UpdateDeviceList(st.models));
      }
    });
  }

  @override
  DeviceListFilterState get initialState =>
      bloc.currentState is DeviceListLoaded
          ? FilterDeviceListLoaded(
              models: (bloc.currentState as DeviceListLoaded).models,
              floorFilter: null,
              statusFilter: CheckStatusFilter.all)
          : FilterDeviceListLoading();

  @override
  Stream<DeviceListFilterState> mapEventToState(
    DeviceListFilterEvent event,
  ) async* {
    if (event is UpdateDeviceList) {
      yield* _mapUpdateDeviceListToState(event);
    }
    if (event is UpdateFilterDeviceList) {
      yield* _mapUpdateFilterToState(event);
    }
    if (event is UpdateFloorFilter) {
      yield* _mapUpdateFloorToState(event);
    }
    if (event is UpdateStatusFilter) {
      yield* _mapUpdateStatusToState(event);
    }
  }

  Stream<DeviceListFilterState> _mapUpdateDeviceListToState(
      UpdateDeviceList event) async* {
    final statusFilter = currentState is FilterDeviceListLoaded
        ? (currentState as FilterDeviceListLoaded).statusFilter
        : CheckStatusFilter.all;
    final floorFilter = currentState is FilterDeviceListLoaded
        ? (currentState as FilterDeviceListLoaded).floorFilter
        : null;
    yield FilterDeviceListLoaded(
      models: _mapFilterToList(event.models, statusFilter, floorFilter),
      floorFilter: floorFilter,
      statusFilter: statusFilter,
    );
  }

  Stream<DeviceListFilterState> _mapUpdateFloorToState(
      UpdateFloorFilter event) async* {
    if (currentState is FilterDeviceListLoaded) {
      yield (currentState as FilterDeviceListLoaded)
          .copy(floorFilter: event.floorFiler);
    }
  }

  Stream<DeviceListFilterState> _mapUpdateStatusToState(
      UpdateStatusFilter event) async* {
    if (currentState is FilterDeviceListLoaded) {
      yield (currentState as FilterDeviceListLoaded)
          .copy(statusFilter: event.statusFilter);
    }
  }

  Stream<DeviceListFilterState> _mapUpdateFilterToState(
      UpdateFilterDeviceList event) async* {
    if (bloc.currentState is DeviceListLoaded &&
        currentState is FilterDeviceListLoaded) {
      yield (currentState as FilterDeviceListLoaded).copy(
        models: _mapFilterToList(
          (bloc.currentState as DeviceListLoaded).models,
          (currentState as FilterDeviceListLoaded).statusFilter,
          (currentState as FilterDeviceListLoaded).floorFilter,
        ),
      );
    }
  }

  List<InspectionDeviceModel> _mapFilterToList(
      List<InspectionDeviceModel> models,
      CheckStatusFilter statusFilter,
      String floorFilter) {
    // ignore: missing_return
    return models.where((item) {
      if (statusFilter == CheckStatusFilter.all) {
        return true;
      } else if (statusFilter == CheckStatusFilter.checked) {
        return item.checkStatus == CheckStatus.checked;
      } else if (statusFilter == CheckStatusFilter.unchecked) {
        return item.checkStatus != CheckStatus.checked;
      }
    }).where((item) {
      if (floorFilter == null) {
        return true;
      } else {
        return item.buildingFloorId == floorFilter;
      }
    }).toList();
  }

  @override
  void dispose() {
    todoSubscription?.cancel();
    super.dispose();
  }
}
