// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_supervisor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPlanEntity _$TaskPlanEntityFromJson(Map<String, dynamic> json) {
  return TaskPlanEntity()
    ..name = json['name'] as String
    ..noteText = json['comment'] as String
    ..currentFloor = (json['check_building_floor_list'] as List)
        ?.map((e) =>
            e == null ? null : FloorEntity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..selectedSystem = (json['check_system_list'] as List)
        ?.map((e) => e == null
            ? null
            : InspectionSystem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..selectedPeople = (json['user_list'] as List)
        ?.map((e) => e == null
            ? null
            : PersonnelMessage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..startTime = timeFromJson(json['start_time'] as String)
    ..endTime = timeFromJson(json['end_time'] as String)
    ..firstStartTime = timeFromJson(json['start_deploy_time'] as String)
    ..taskExecuteTime = executeTimeFromJson(json['task_execute_time'] as String)
    ..cycle = cycleFromJson(json['cycle'] as String);
}

Map<String, dynamic> _$TaskPlanEntityToJson(TaskPlanEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'comment': instance.noteText,
      'check_building_floor_list': instance.currentFloor,
      'check_system_list': instance.selectedSystem,
      'user_list': instance.selectedPeople,
      'start_time': timeToJson(instance.startTime),
      'end_time': timeToJson(instance.endTime),
      'start_deploy_time': firstStartTimeToJson(instance.firstStartTime),
      'task_execute_time': executeTimeToJson(instance.taskExecuteTime),
      'cycle': cycleToJson(instance.cycle),
    };

PlanTaskListPageModel _$PlanListPageModelFromJson(Map<String, dynamic> json) {
  return PlanTaskListPageModel(
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

Map<String, dynamic> _$PlanListPageModelToJson(PlanTaskListPageModel instance) =>
    <String, dynamic>{
      'content': instance.planLists,
      'number': instance.currentPageNum,
      'total_pages': instance.totalPageNum,
      'total_elements': instance.totalElementNum,
    };
