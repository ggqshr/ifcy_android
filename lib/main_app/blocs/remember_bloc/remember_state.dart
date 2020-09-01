part of 'remember_bloc.dart';

abstract class RememberState extends Equatable {
  RememberState([List props = const <dynamic>[]]) : super([]);
}

class RememberInitial extends RememberState {
  RememberInitial() : super([]);
}

class RememberLoadedState extends RememberState {
  final List<LoginUserInfo> infos;

  RememberLoadedState(this.infos) : super([infos]);
}
