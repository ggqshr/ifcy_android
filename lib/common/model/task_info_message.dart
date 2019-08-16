enum TaskStatus {
  completed, //已完成
  uncompleted, //未完成
}

Map<int, String> taskStatusEnumMap = {
  0: "完成",
  1: "未完成",
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
class TaskDetailMessage{
  String des;
  String type;
  String executor;
  int progress;
  TaskDetailMessage({this.des,this.type,this.executor,this.progress});
}

