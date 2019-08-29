// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspectionTaskModel _$InspectionTaskModelFromJson(Map<String, dynamic> json) {
  return InspectionTaskModel(
    json['id'] as String,
    json['name'] as String,
    taskStatusFromJson(json['task_status'] as String),
    json['comment'] as String,
    json['device_num'] as String,
    json['checked_device_num'] as String,
    (json['check_building_floor_list'] as List)
        ?.map((e) =>
            e == null ? null : FloorEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['check_system_list'] as List)
        ?.map((e) => e == null
            ? null
            : InspectionSystem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    timeFromJson(json['start_time'] as String),
    timeFromJson(json['end_time'] as String),
  );
}

Map<String, dynamic> _$InspectionTaskModelToJson(
        InspectionTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'task_status': taskStatusToJson(instance.taskStatus),
      'comment': instance.noteText,
      'device_num': instance.deviceNum,
      'checked_device_num': instance.checkedDeviceNum,
      'check_building_floor_list': instance.currentFloor,
      'check_system_list': instance.selectedSystem,
      'start_time': timeToJson(instance.startTime),
      'end_time': timeToJson(instance.endTime),
    };

InspectionTaskPageModel _$InspectionTaskPageModelFromJson(
    Map<String, dynamic> json) {
  return InspectionTaskPageModel(
    taskInfoList: (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : InspectionTaskModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPageNum: json['number'] as int,
    totalPageNum: json['total_pages'] as int,
    totalElementNum: json['total_elements'] as int,
  );
}

Map<String, dynamic> _$InspectionTaskPageModelToJson(
        InspectionTaskPageModel instance) =>
    <String, dynamic>{
      'content': instance.taskInfoList,
      'number': instance.currentPageNum,
      'total_pages': instance.totalPageNum,
      'total_elements': instance.totalElementNum,
    };
