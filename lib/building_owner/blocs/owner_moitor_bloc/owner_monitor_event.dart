import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OwnerMonitorEvent extends Equatable {
  OwnerMonitorEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchOwnerMonitorDataEvent extends OwnerMonitorEvent{}

class UpdateOwnerMonitorDataEvent extends OwnerMonitorEvent{}