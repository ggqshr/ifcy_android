import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfirmMessageState extends Equatable {
  ConfirmMessageState([List props = const <dynamic>[]]) : super(props);
}

///初始化显示的数据
class LoadingConfirmDataState extends ConfirmMessageState {}

class LoadedConfirmDataState extends ConfirmMessageState {
  final AlarmMessage message;

  LoadedConfirmDataState(this.message) : super([message]);
}

class ConfirmedState extends ConfirmMessageState {
  final AlarmMessage message;
  final bool isSuccess;
  final bool isFault;
  final bool isConfirming;
  final bool result;

  ConfirmedState(
      {this.message,
      this.isSuccess,
      this.isFault,
      this.isConfirming,
      this.result})
      : super([message, isSuccess, isFault, isConfirming, result]);

  ConfirmedState.confirming(message)
      : message = message,
        isSuccess = false,
        isFault = false,
        isConfirming = true,
        result = false;

  ConfirmedState success(res) {
    return ConfirmedState(
      message: this.message,
      isSuccess: true,
      isFault: false,
      isConfirming: false,
      result: res,
    );
  }

  ConfirmedState fault() {
    return ConfirmedState(
      message: this.message,
      isSuccess: false,
      isFault: true,
      isConfirming: false,
    );
  }

  @override
  String toString() {
    return 'ConfirmedState{message: $message, isSuccess: $isSuccess, isFault: $isFault, isConfirming: $isConfirming, result: $result}';
  }

}
