// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    userName: json['username'] as String,
    realName: json['real_name'] as String,
    roleType: json['role_type'] as String,
    buildingCode: json['building_code'] as String,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'real_name': instance.realName,
      'role_type': instance.roleType,
      'building_code': instance.buildingCode,
    };
