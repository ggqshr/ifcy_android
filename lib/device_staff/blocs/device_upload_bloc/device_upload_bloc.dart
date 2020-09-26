import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import 'package:ifcy/device_staff/blocs/device_upload_bloc/device_upload_event.dart';
import 'package:ifcy/device_staff/repositories/device_check_repositories.dart';

import './bloc.dart';

///要依赖
class DeviceUploadBloc extends Bloc<DeviceUploadEvent, DeviceUploadState> {
  DeviceCheckRepositories repositories;
  DeviceUploadBloc(this.repositories);
  @override
  DeviceUploadState get initialState => InitialDeviceUploadState();

  @override
  Stream<DeviceUploadState> mapEventToState(
    DeviceUploadEvent event,
  ) async* {
    if (event is GetUploadData) {
      yield* _mapGetDataToState(event);
    }
    if (event is UploadToServer) {
      yield* _mapUploadToState(event);
    }
  }

  Stream<DeviceUploadState> _mapGetDataToState(GetUploadData event) async* {
    yield LoadedUploadDevice(models: event.models);
  }

  Stream<DeviceUploadState> _mapUploadToState(UploadToServer event) async* {
    yield (state as LoadedUploadDevice).uploading();
    try {
      await repositories.uploadDevice((state as LoadedUploadDevice).models);
      yield (state as LoadedUploadDevice).success();
    } catch (e) {
      yield (state as LoadedUploadDevice).fault();
      rethrow;
    }
  }
}
