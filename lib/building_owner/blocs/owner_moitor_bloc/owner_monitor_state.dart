import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OwnerMonitorState extends Equatable {
  OwnerMonitorState([List props = const <dynamic>[]]) : super(props);
}

class LoadingOwnerMonitorDataState extends OwnerMonitorState {}

class LoadedOwnerMonitorDataState extends OwnerMonitorState {
  ///火警发生数
  final int fireNum;

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

  final List<PersonnelMessage> userList;

  LoadedOwnerMonitorDataState({
    @required this.fireNum,
    @required this.deviceFaultNum,
    @required this.taskCompleteRate,
    @required this.fireAlarmMsg,
    @required this.deviceFaultMsg,
    @required this.taskInfoMsg,
    @required this.userList,
  }):super([
    fireNum,
    deviceFaultNum,
    taskCompleteRate,
    fireAlarmMsg,
    deviceFaultMsg,
    taskInfoMsg,
    userList,
  ]);

  LoadedOwnerMonitorDataState copyWith({
    int fireNum,
    int deviceFaultNum,
    int taskCompleteRate,
    List<FireAlarmMessage> fireAlarmMsg,
    List<DeviceFaultAlarmMessage> deviceFaultMsg,
    List<TaskInfoMessage> taskInfoMsg,
    List<PersonnelMessage> userList,
  }) {
    return LoadedOwnerMonitorDataState(
      fireNum: fireNum ?? this.fireNum,
      deviceFaultNum: deviceFaultNum ?? this.deviceFaultNum,
      taskCompleteRate: taskCompleteRate ?? this.taskCompleteRate,
      fireAlarmMsg: fireAlarmMsg ?? this.fireAlarmMsg,
      deviceFaultMsg: deviceFaultMsg ?? this.deviceFaultMsg,
      taskInfoMsg: taskInfoMsg ?? this.taskInfoMsg,
      userList: userList ?? this.userList,
    );
  }

  @override
  String toString() {
    return 'LoadedOwnerMonitorDataState{fireNum: $fireNum, deviceFaultNum: $deviceFaultNum, taskCompleteRate: $taskCompleteRate, fireAlarmMsg: $fireAlarmMsg, deviceFaultMsg: $deviceFaultMsg, taskInfoMsg: $taskInfoMsg, userList: $userList}';
  }


}

class LoadErrorOwnerMonitorDataState extends OwnerMonitorState {}
