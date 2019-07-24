enum TaskStatus {
  completed, //已完成
  uncompleted, //未完成
}

/// 任务消息的实体类
class TaskInfoMessage {
  String id;
  String title;
  String content;
  TaskStatus status;

  TaskInfoMessage({this.id, this.title, this.content, this.status});
}
