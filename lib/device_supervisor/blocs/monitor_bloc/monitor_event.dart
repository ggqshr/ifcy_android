import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MonitorEvent extends Equatable {
  MonitorEvent([List props = const <dynamic>[]]) : super(props);
}
