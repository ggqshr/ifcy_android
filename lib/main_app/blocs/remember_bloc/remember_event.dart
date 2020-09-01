part of 'remember_bloc.dart';

abstract class RememberEvent extends Equatable {
  RememberEvent([List props = const <dynamic>[]]) : super([]);
}

class FetchUserLoginInfosEvent extends RememberEvent {}

class DeleteUserLoginInfosEvent extends RememberEvent {
  final String userName;

  DeleteUserLoginInfosEvent(this.userName);
}
