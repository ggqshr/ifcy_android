part of "model.dart";

/// 部门实体类
class DepartmentMessage {
  String id;
  String title;
  List<PersonnelMessage> personnelList;

  DepartmentMessage({this.id, this.title, this.personnelList});
}

///人员信息
@JsonSerializable()
class PersonnelMessage {
  String id;
  @JsonKey(name: "real_name")
  String name;
  String mobile;
  @JsonKey(name: "role_type")
  String roleType;
  bool enable;

  PersonnelMessage({this.id, this.name,this.roleType,this.enable,this.mobile});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonnelMessage &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory PersonnelMessage.fromJson(Map<String, dynamic> json) =>
      _$PersonnelMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PersonnelMessageToJson(this);
}
