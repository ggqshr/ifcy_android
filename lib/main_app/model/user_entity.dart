///@author ggq
///@description:
///@date :2019/8/25 18:40
part of "AppState.dart";

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "username")
  String userName;
  @JsonKey(name: "real_name")
  String realName;
  @JsonKey(name: "role_type")
  String roleType;
  @JsonKey(name:"building_code")
  String buildingCode;

  UserEntity({this.userName, this.realName, this.roleType,this.buildingCode});

  UserEntity copyWith({userName, realName, roleType,buildingCode}) {
    return UserEntity(
      userName: userName ?? this.userName,
      realName: realName ?? this.realName,
      roleType: roleType ?? this.roleType,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
