part of "model.dart";

enum TaskStatus {
  ///已完成
  completed,

  ///未完成
  uncompleted,

  ///未启动
  unreached,

  ///已启动,未完成
  running,

  ///超时完成
  out_time_completed,
}

Map<int, String> taskStatusEnumMap = {
  0: "完成",
  1: "超时未完成",
  2: "未启动",
  3: "已启动",
  4: "超时完成"
};

/// 任务消息的实体类
class TaskInfoMessage {
  String id;
  String title;
  String content;
  TaskStatus status;

  TaskInfoMessage({this.id, this.title, this.content, this.status});
}

///任务的具体描述类
class TaskDetailMessage {
  String des;
  String type;
  String executor;
  int progress;

  TaskDetailMessage({this.des, this.type, this.executor, this.progress});
}
