import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BadgeBloc extends Bloc<BadgeEvent, List<int>> {
  @override
  List<int> get initialState => [1,0,0,0];

  @override
  Stream<List<int>> mapEventToState(
    BadgeEvent event,
  ) async* {
    if(event is AddBadgeNum){
      var newList = List.from(currentState);
      newList[event.badgeIndex]+=event.badgeNum;
      yield newList;
    }
    if(event is DecreaseBadgeNum){
      var newList = List.from(currentState);
      newList[event.badgeIndex]-=event.badgeNum;
      yield newList;
    }
  }
}
