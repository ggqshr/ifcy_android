import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckDeclareEvent extends Equatable {
  CheckDeclareEvent([List props = const <dynamic>[]]) : super(props);
}

class CheckPassDeclareMessageEvent extends CheckDeclareEvent {
  final String id;

  CheckPassDeclareMessageEvent(this.id) : super([id]);
}
