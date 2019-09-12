import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeclareMessageState extends Equatable {
  DeclareMessageState([List props = const <dynamic>[]]) : super(props);
}

class LoadingDeclareMessageState extends DeclareMessageState {}

class LoadedDeclareMessageState extends DeclareMessageState {
  final PageDataModel models;
  final bool isReachMax;

  LoadedDeclareMessageState({this.models, this.isReachMax})
      : super([models, isReachMax]);
  LoadedDeclareMessageState copy({models, isReachMax}) {
    return LoadedDeclareMessageState(
        isReachMax: isReachMax ?? this.isReachMax,
        models: models ?? this.models);
  }
}

class LoadErrorDeclareMessageState extends DeclareMessageState {}
