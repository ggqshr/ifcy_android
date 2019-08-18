///火灾消息实体类
class FireAlarmMessage {
  String id;
  String title;
  String content;

  FireAlarmMessage({this.id, this.title, this.content});

  FireAlarmMessage.generate(id)
  :title='火警消息$id',
  content="火警内容$id";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FireAlarmMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}
