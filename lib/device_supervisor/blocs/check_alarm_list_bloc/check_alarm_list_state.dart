import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckAlarmListState extends Equatable {
  CheckAlarmListState([List props = const <dynamic>[]]) : super(props);
}

class LoadingCheckAlarmState extends CheckAlarmListState {}

class LoadedCheckAlarmState extends CheckAlarmListState {
  final PageDataModel model;
  final bool isReachMax;

//<editor-fold desc="Data Methods" defaultstate="collapsed">


  LoadedCheckAlarmState({
    @required this.model,
    @required this.isReachMax,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is LoadedCheckAlarmState &&
              runtimeType == other.runtimeType &&
              model == other.model &&
              isReachMax == other.isReachMax
          );


  @override
  int get hashCode =>
      model.hashCode ^
      isReachMax.hashCode;


  @override
  String toString() {
    return 'LoadedCheckAlarmState{' +
        ' model: $model,' +
        ' isReachMax: $isReachMax,' +
        '}';
  }


  LoadedCheckAlarmState copyWith({
    PageDataModel model,
    bool isReachMax,
  }) {
    return LoadedCheckAlarmState(
      model: model ?? this.model,
      isReachMax: isReachMax ?? this.isReachMax,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'model': this.model,
      'isReachMax': this.isReachMax,
    };
  }

  factory LoadedCheckAlarmState.fromMap(Map<String, dynamic> map) {
    return LoadedCheckAlarmState(
      model: map['model'] as PageDataModel,
      isReachMax: map['isReachMax'] as bool,
    );
  }


//</editor-fold>
}

class FilteringCheckAlarmState extends CheckAlarmListState {
  final PageDataModel model;
  final bool isReachMax;
  final DateTime date;

  FilteringCheckAlarmState({
    @required this.model,
    @required this.isReachMax,
    this.date,
  });



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FilteringCheckAlarmState &&
              runtimeType == other.runtimeType &&
              model == other.model &&
              isReachMax == other.isReachMax
          );

  @override
  int get hashCode =>
      model.hashCode ^
      isReachMax.hashCode;

  @override
  String toString() {
    return 'FilteringCheckAlarmState{' +
        ' model: $model,' +
        ' isReachMax: $isReachMax,' +
        '}';
  }

  FilteringCheckAlarmState copyWith({
    PageDataModel model,
    bool isReachMax,
  }) {
    return FilteringCheckAlarmState(
      model: model ?? this.model,
      isReachMax: isReachMax ?? this.isReachMax,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': this.model,
      'isReachMax': this.isReachMax,
    };
  }

  factory FilteringCheckAlarmState.fromMap(Map<String, dynamic> map) {
    return FilteringCheckAlarmState(
      model: map['model'] as PageDataModel,
      isReachMax: map['isReachMax'] as bool,
    );
  }
}

class LoadErrorCheckAlarmState extends CheckAlarmListState {}

