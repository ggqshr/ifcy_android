import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckDeclareState extends Equatable {
  CheckDeclareState([List props = const <dynamic>[]]) : super(props);
}

class CheckStatusDeclareState extends CheckDeclareState {
  final bool isChecking;
  final bool isSuccess;
  final bool isFault;

  CheckStatusDeclareState({this.isChecking, this.isSuccess, this.isFault})
      : super([
          isChecking,
          isSuccess,
          isFault,
        ]);

  factory CheckStatusDeclareState.init() => CheckStatusDeclareState(
        isChecking: false,
        isSuccess: false,
        isFault: false,
      );

  factory CheckStatusDeclareState.success() => CheckStatusDeclareState(
        isChecking: false,
        isSuccess: true,
        isFault: false,
      );

  factory CheckStatusDeclareState.fault() => CheckStatusDeclareState(
        isChecking: false,
        isSuccess: false,
        isFault: true,
      );
  factory CheckStatusDeclareState.checking() => CheckStatusDeclareState(
        isChecking: true,
        isSuccess: false,
        isFault: false,
      );
}
