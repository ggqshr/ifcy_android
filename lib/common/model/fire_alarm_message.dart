part of "model.dart";
///火灾消息实体类
class FireAlarmMessage {
  String id;
  String title;
  String content;

  FireAlarmMessage({this.id, this.title, this.content});

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
