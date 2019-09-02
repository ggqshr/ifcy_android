import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MonitorState extends Equatable {
  MonitorState([List props = const <dynamic>[]]) : super(props);
}

///未初始化的状态，body部分显示加载框
class UnInitializationMonitorState extends MonitorState {}

class LoadedMonitorState extends MonitorState {
  ///设备故障数
  final int deviceFaultNum;

  ///任务完成进度
  final int taskCompleteRate;

  ///火警消息
  final List<FireAlarmMessage> fireAlarmMsg;

  ///设备顾航
  final List<DeviceFaultAlarmMessage> deviceFaultMsg;

  ///任务信息
  final List<TaskInfoMessage> taskInfoMsg;

  LoadedMonitorState(
      {this.deviceFaultNum,
      this.taskCompleteRate,
      this.fireAlarmMsg,
      this.deviceFaultMsg,
      this.taskInfoMsg})
      : super([
          deviceFaultNum,
          taskCompleteRate,
          fireAlarmMsg,
          deviceFaultMsg,
          taskInfoMsg,
        ]);

  LoadedMonitorState copy({
    taskCompleteRate,
    fireAlarmMsg,
    deviceFaultMsg,
    taskInfoMsg,
    deviceFaultNum,
  }) {
    return LoadedMonitorState(
      taskCompleteRate: taskCompleteRate ?? this.taskCompleteRate,
      fireAlarmMsg: fireAlarmMsg ?? this.fireAlarmMsg,
      deviceFaultMsg: deviceFaultMsg ?? this.deviceFaultMsg,
      taskInfoMsg: taskInfoMsg ?? this.taskInfoMsg,
      deviceFaultNum: deviceFaultNum ?? this.deviceFaultNum,
    );
  }

  @override
  String toString() {
    return 'LoadedMonitorState{deviceFaultNum: $deviceFaultNum, taskCompleteRate: $taskCompleteRate, fireAlarmMsg: $fireAlarmMsg, deviceFaultMsg: $deviceFaultMsg, taskInfoMsg: $taskInfoMsg}';
  }
}

class LoadedErrorMonitorState extends MonitorState {}
