import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeclareMessageEvent extends Equatable {
  DeclareMessageEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchDeclareMessage extends DeclareMessageEvent {}

class RefreshDeclareMessage extends DeclareMessageEvent {}
