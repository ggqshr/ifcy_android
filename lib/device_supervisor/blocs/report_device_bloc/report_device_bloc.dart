import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/repositories/report_device_repositories.dart';

import './bloc.dart';

class ReportDeviceBloc extends Bloc<ReportDeviceEvent, ReportDeviceState> {
  final ReportDeviceRepositories repositories;

  ReportDeviceBloc(this.repositories);

  @override
  ReportDeviceState get initialState => LoadingReportDevicesState();

  @override
  Stream<ReportDeviceState> mapEventToState(
    ReportDeviceEvent event,
  ) async* {
    if (event is FetchReportDevice) {
      yield* _mapFetchToState();
    }
    if (event is AddToReportList) {
      final List<String> currentList =
          List.from((state as LoadedReportDevicesState).devicesToReport);
      yield (state as LoadedReportDevicesState).copyWith(
        devicesToReport: currentList..add(event.code),
      );
    }
    if (event is RemoveFromReportList) {
      final List<String> currentList =
          List.from((state as LoadedReportDevicesState).devicesToReport);
      currentList.remove(event.code);
      yield (state as LoadedReportDevicesState).copyWith(
        devicesToReport: currentList,
      );
    }
    if (event is ReportToServer) {
      yield* _mapReportToState(event);
    }
  }

  Stream<ReportDeviceState> _mapFetchToState() async* {
    try {
      final List<DeviceMessage> model = await repositories.getDeviceList();
      yield LoadedReportDevicesState(
        devicesToShow: model,
        devicesToReport: [],
        isSubmitting: false,
        isSuccess: false,
        isFault: false,
      );
    } catch (e, s) {
      yield LoadErrorReportDevicesState();
      rethrow;
    }
  }

  Stream<ReportDeviceState> _mapReportToState(ReportToServer event ) async* {
    try {
      yield (state as LoadedReportDevicesState).submitting();
      await repositories.reportToServer(
          (state as LoadedReportDevicesState).devicesToReport,event.title,event.content);
      yield (state as LoadedReportDevicesState).success();
    } catch (e, s) {
      yield (state as LoadedReportDevicesState).fault();
      rethrow;
    }
  }
}
