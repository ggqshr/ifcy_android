import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';

import 'bloc.dart';

class BadgeBloc extends Bloc<BadgeEvent, List<int>> {
  final List<int> blocInitState;
  final MonitorBloc monitorBloc;
  StreamSubscription monitorSubscription;


  BadgeBloc(this.blocInitState,{this.monitorBloc}){
    if(monitorBloc!=null){
      monitorSubscription = monitorBloc.listen((sta){
        if(sta is LoadedMonitorState){
          int totalCount = sta.fireAlarmMsg.length+sta.deviceFaultMsg.length+sta.taskInfoMsg.length;
          add(SetBadgeNum(badgeNum: totalCount,badgeIndex: 0));
        }
      });
    }
  }

  @override
  List<int> get initialState => blocInitState;

  @override
  Stream<List<int>> mapEventToState(
    BadgeEvent event,
  ) async* {
    if(event is AddBadgeNum){
      var newList = List.from(state);
      newList[event.badgeIndex]+=event.badgeNum;
      yield newList;
    }
    if(event is DecreaseBadgeNum){
      var newList = List.from(state);
      newList[event.badgeIndex]-=event.badgeNum;
      yield newList;
    }
    if(event is SetBadgeNum){
      List<int> newList = List.from(state);
      newList[event.badgeIndex]=event.badgeNum;
      yield newList;
    }
  }

  @override
  void dispose() {
    monitorSubscription.cancel();
    super.close();
  }

}
