import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/repositories/confirm_message_repositories.dart';
import './bloc.dart';

class ConfirmMessageBloc
    extends Bloc<ConfirmMessageEvent, ConfirmMessageState> {
  final ConfirmMessageRepositories _repositories;
  final AlarmMessage message;

  ConfirmMessageBloc(this.message, [repo])
      : _repositories = repo ?? ConfirmMessageRepositories();

  @override
  ConfirmMessageState get initialState => LoadingConfirmDataState();

  @override
  Stream<ConfirmMessageState> mapEventToState(
    ConfirmMessageEvent event,
  ) async* {
    if (event is StartToConfirm && state is LoadingConfirmDataState) {
      yield LoadedConfirmDataState(message);
    }
    if (event is ConfirmMessage) {
      yield* _mapConfirmToState(event);
    }
  }

  Stream<ConfirmMessageState> _mapConfirmToState(ConfirmMessage event) async* {
    if (state is LoadedConfirmDataState) {
      ///开始加载
      yield ConfirmedState.confirming(message);
      try {
        if (message is FireAlarmMessage) {
          if (!event.isFireOrProcessed) {
            await _repositories.confirmFireFault(
                (message as FireAlarmMessage).id, event.commentText);
          } else {
            await _repositories.confirmFireFire(
                (message as FireAlarmMessage).id, event.commentText);
          }
        } else if (message is DeviceFaultAlarmMessage) {
          if (!event.isFireOrProcessed) {
            await _repositories.confirmDeviceUnProcessed(
                (message as DeviceFaultAlarmMessage).id, event.commentText);
          } else {
            await _repositories.confirmDeviceProcessed(
                (message as DeviceFaultAlarmMessage).id, event.commentText);
          }
        }
        yield (state as ConfirmedState).success(event.isFireOrProcessed);
      } catch (e) {
        yield (state as ConfirmedState).fault();
        rethrow;
      }
    }
  }
}
