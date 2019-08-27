import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  @override
  MonitorState get initialState => InitialMonitorState();

  @override
  Stream<MonitorState> mapEventToState(
    MonitorEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
