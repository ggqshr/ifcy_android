// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_supervisor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPlanEntity _$TaskPlanEntityFromJson(Map<String, dynamic> json) {
  return TaskPlanEntity()
    ..name = json['name'] as String
    ..currentBuild = buildJsonFunc(json['check_building_id'] as int)
    ..currentFloor = (json['check_building_floor_list'] as List)
        ?.map((e) =>
            e == null ? null : FloorEntity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..selectedSystem = (json['check_system_list'] as List)
        ?.map((e) => e == null
            ? null
            : InspectionSystem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..selectedPeople = (json['plan_user_list'] as List)
        ?.map((e) => e == null
            ? null
            : PersonnelMessage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..startTime = json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String)
    ..endTime = json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String)
    ..firstStartTime = timeFromJson(json['start_deploy_time'] as int)
    ..taskExecuteTime = executeTimeFromJson(json['task_execute_time'] as int)
    ..cycle = cycleFromJson(json['cycle'] as String)
    ..isEnable = json['isEnable'] as bool;
}

Map<String, dynamic> _$TaskPlanEntityToJson(TaskPlanEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'check_building_id': buildFromJson(instance.currentBuild),
      'check_building_floor_list': instance.currentFloor,
      'check_system_list': instance.selectedSystem,
      'plan_user_list': instance.selectedPeople,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'start_deploy_time': instance.firstStartTime?.toIso8601String(),
      'task_execute_time': instance.taskExecuteTime,
      'cycle': cycleToJson(instance.cycle),
      'isEnable': instance.isEnable,
    };

PlanListPageModel _$PlanListPageModelFromJson(Map<String, dynamic> json) {
  return PlanListPageModel(
    planLists: (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : TaskPlanEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPageNum: json['number'] as int,
    totalPageNum: json['total_pages'] as int,
    totalElementNum: json['total_elements'] as int,
  );
}

Map<String, dynamic> _$PlanListPageModelToJson(PlanListPageModel instance) =>
    <String, dynamic>{
      'content': instance.planLists,
      'number': instance.currentPageNum,
      'total_pages': instance.totalPageNum,
      'total_elements': instance.totalElementNum,
    };
