// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_inspection_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegularInspectionTaskDetail _$RegularInspectionTaskDetailFromJson(
    Map<String, dynamic> json) {
  return RegularInspectionTaskDetail(
    deviceName: json['deviceName'],
    deviceId: json['deviceId'],
    deviceType: json['deviceType'],
    inspectionRequire: json['inspectionRequire'],
    inspectionResultType: _$enumDecodeNullable(
        _$InspectionResultTypeEnumMap, json['inspectionResultType']),
    processType:
        _$enumDecodeNullable(_$ProcessTypeEnumMap, json['processType']),
    noteText: json['noteText'],
    taskStatus: _$enumDecodeNullable(_$TaskStatusEnumMap, json['taskStatus']),
    taskArea: json['taskArea'],
    taskFloor: json['taskFloor'],
    isUpload: json['isUpload'],
  );
}

Map<String, dynamic> _$RegularInspectionTaskDetailToJson(
        RegularInspectionTaskDetail instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'inspectionRequire': instance.inspectionRequire,
      'inspectionResultType':
          _$InspectionResultTypeEnumMap[instance.inspectionResultType],
      'processType': _$ProcessTypeEnumMap[instance.processType],
      'noteText': instance.noteText,
      'taskStatus': _$TaskStatusEnumMap[instance.taskStatus],
      'taskArea': instance.taskArea,
      'taskFloor': instance.taskFloor,
      'isUpload': instance.isUpload,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$InspectionResultTypeEnumMap = {
  InspectionResultType.normal: 'normal',
  InspectionResultType.defect: 'defect',
  InspectionResultType.fault: 'fault',
};

const _$ProcessTypeEnumMap = {
  ProcessType.repair: 'repair',
  ProcessType.requireChange: 'requireChange',
  ProcessType.requireRepair: 'requireRepair',
};

const _$TaskStatusEnumMap = {
  TaskStatus.completed: 'completed',
  TaskStatus.uncompleted: 'uncompleted',
};
