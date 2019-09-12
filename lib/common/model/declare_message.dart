part of "model.dart";

@JsonSerializable()
class DeclareMessage {
  String id;
  String title;
  String comment;
  @JsonKey(name: "device_list")
  List deviceList;
  @JsonKey(name: "post_user_id")
  int postUserId;
  @JsonKey(name: "checked_user_id")
  int checkedUserId;
  bool checked;
  DeclareMessage(
      {this.id,
      this.title,
      this.comment,
      this.deviceList,
      this.postUserId,
      this.checkedUserId,
      this.checked});
  factory DeclareMessage.fromJson(Map<String, dynamic> json) =>
      _$DeclareMessageFromJson(json);

  Map<String, dynamic> toJson() => _$DeclareMessageToJson(this);
}
