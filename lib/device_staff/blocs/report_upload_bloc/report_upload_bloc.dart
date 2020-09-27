import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_staff/repositories/repositories.dart';
import '../device_staff_blocs.dart';
import '../device_staff_blocs.dart';
import './bloc.dart';

class ReportUploadBloc
    extends Bloc<ReportUploadEvent, ReportUploadState> {
//  final DeviceStaffDeviceCheckBloc bloc;
  DeviceCheckRepositories repositories;
  StreamSubscription todoSubscription;

  ReportUploadBloc(this.repositories);

  @override
  ReportUploadState get initialState => InitialReportUploadState();

  @override
  Stream<ReportUploadState> mapEventToState(ReportUploadEvent event) async*{
    if(event is GetReportDevice) {
      yield* _mapGetReportDeviceToState(event);
    }
    if (event is ReportToServer) {
      yield* _mapReportToState(event);
    }
    if (event is AddToReport) {
      final List<String> currentList =
      List.from((state as ReportDeviceProblemState).devicesToReport);
      yield (state as ReportDeviceProblemState).copyWith(
        devicesToReport: currentList..add(event.code),
      );
    }
    if (event is RemoveFromReport) {
      final List<String> currentList =
      List.from((state as ReportDeviceProblemState).devicesToReport);
      currentList.remove(event.code);
      yield (state as ReportDeviceProblemState).copyWith(
        devicesToReport: currentList,
      );
    }
  }

  Stream<ReportDeviceProblemState> _mapGetReportDeviceToState(GetReportDevice event) async* {
    yield ReportDeviceProblemState(
        models: event.models,
        devicesToReport: [],
        isUploading: false,
        isSuccess: false,
        isFault: false,
        );
  }

  Stream<ReportDeviceProblemState> _mapReportToState(ReportToServer event) async* {
    yield (state as ReportDeviceProblemState).uploading();
    try {
      ///从这里进入访问后端的函数
      await repositories.reportDevice((state as ReportDeviceProblemState).devicesToReport);
      yield (state as ReportDeviceProblemState).success();
    } catch (e) {
      yield (state as ReportDeviceProblemState).fault();
      rethrow;
    }
  }

  @override
  void dispose() {
    todoSubscription?.cancel();
    super.close();
  }
}
