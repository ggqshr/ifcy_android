///故障消息实体类
class DeviceFaultMessage {
  String id;
  String title;
  String content;

  DeviceFaultMessage({this.id, this.title, this.content});

  DeviceFaultMessage.generate(id)
      :title='火警消息$id',
        content="火警内容$id";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceFaultMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}
