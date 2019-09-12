part of "model.dart";

@JsonSerializable()
class DeclareMessage {
  String id;
  String title;
  String comment;
  @JsonKey(name: "device_list")
  List deviceList;
  @JsonKey(name: "post_user_id")
  String postUserId;
  @JsonKey(name: "checked_user_id")
  String checkedUserId;
  bool checked;
  DeclareMessage({id,title,comment,deviceList,postUserId,checkedUserId,checked});
  factory DeclareMessage.fromJson(Map<String, dynamic> json) =>
      _$DeclareMessageFromJson(json);

  Map<String, dynamic> toJson() => _$DeclareMessageToJson(this);
  
}
