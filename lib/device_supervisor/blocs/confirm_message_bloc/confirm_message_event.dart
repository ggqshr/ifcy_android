import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfirmMessageEvent extends Equatable {
  ConfirmMessageEvent([List props = const <dynamic>[]]) : super(props);
}

///开始显示数据
class StartToConfirm extends ConfirmMessageEvent {}

///确认消息
class ConfirmMessage extends ConfirmMessageEvent {
  final bool isFireOrProcessed;
  final String commentText;

  ConfirmMessage(this.isFireOrProcessed, this.commentText);

  @override
  String toString() {
    return 'ConfirmMessage{isFireOrProcessed: $isFireOrProcessed $commentText}';
  }
}
