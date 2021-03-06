// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireAlarmMessage _$FireAlarmMessageFromJson(Map<String, dynamic> json) {
  return FireAlarmMessage(
    eventId: json['event_id'] as String,
    deviceName: json['device_name'] as String,
    sendTime: timeFromJson(json['send_time'] as String),
    deviceCode: json['device_code'] as String,
    checked: json['checked'] as bool,
    mainEngineCode: json['main_engine_code'] as String,
    id: json['id'] as String,
    floorAreaName: json['floor_area_name'] as String,
    floorName: json['floor_name'] as String,
  )..floorId = json['floor_id'] as String;
}

Map<String, dynamic> _$FireAlarmMessageToJson(FireAlarmMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'device_name': instance.deviceName,
      'send_time': timeToJson(instance.sendTime),
      'device_code': instance.deviceCode,
      'checked': instance.checked,
      'main_engine_code': instance.mainEngineCode,
      'id': instance.id,
      'floor_area_name': instance.floorAreaName,
      'floor_name': instance.floorName,
      'floor_id': instance.floorId,
    };

DeviceFaultAlarmMessage _$DeviceFaultAlarmMessageFromJson(
    Map<String, dynamic> json) {
  return DeviceFaultAlarmMessage(
    eventId: json['event_id'] as String,
    deviceName: json['device_name'] as String,
    sendTime: timeFromJson(json['send_time'] as String),
    deviceCode: json['device_code'] as String,
    checked: json['checked'] as bool,
    mainEngineCode: json['main_engine_code'] as String,
    id: json['id'] as String,
    floorAreaName: json['floor_area_name'] as String,
    floorName: json['floor_name'] as String,
  )..floorId = json['floor_id'] as String;
}

Map<String, dynamic> _$DeviceFaultAlarmMessageToJson(
        DeviceFaultAlarmMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'device_name': instance.deviceName,
      'send_time': timeToJson(instance.sendTime),
      'device_code': instance.deviceCode,
      'checked': instance.checked,
      'main_engine_code': instance.mainEngineCode,
      'id': instance.id,
      'floor_area_name': instance.floorAreaName,
      'floor_name': instance.floorName,
      'floor_id': instance.floorId,
    };

FireCheckAlarmMessage _$FireCheckAlarmMessageFromJson(
    Map<String, dynamic> json) {
  return FireCheckAlarmMessage(
    eventId: json['event_id'] as String,
    deviceName: json['device_name'] as String,
    recordTime: timeFromJson(json['record_time'] as String),
    deviceCode: json['device_code'] as String,
    checked: json['checked'] as bool,
    engineCode: json['engine_code'] as String,
    id: json['id'] as String,
    checkUserId: json['check_user_id'] as String,
    warningMessageId: json['warning_message_id'] as String,
    fireType: json['fire_type'] as String,
  )
    ..checkTIme = json['check_time'] as String
    ..checkUserRealName = json['check_user_real_name'] as String;
}

Map<String, dynamic> _$FireCheckAlarmMessageToJson(
        FireCheckAlarmMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'device_name': instance.deviceName,
      'record_time': timeToJson(instance.recordTime),
      'device_code': instance.deviceCode,
      'checked': instance.checked,
      'engine_code': instance.engineCode,
      'id': instance.id,
      'check_user_id': instance.checkUserId,
      'warning_message_id': instance.warningMessageId,
      'fire_type': instance.fireType,
      'check_time': instance.checkTIme,
      'check_user_real_name': instance.checkUserRealName,
    };

DeviceCheckedAlarmMessage _$DeviceCheckedAlarmMessageFromJson(
    Map<String, dynamic> json) {
  return DeviceCheckedAlarmMessage(
    eventId: json['event_id'] as String,
    deviceName: json['device_name'] as String,
    recordTime: timeFromJson(json['record_time'] as String),
    deviceCode: json['device_code'] as String,
    checked: json['checked'] as bool,
    engineCode: json['engine_code'] as String,
    id: json['id'] as String,
    checkUserId: json['check_user_id'] as String,
    warningMessageId: json['warning_message_id'] as String,
    faultType: json['fault_type'] as String,
    checkTIme: json['check_time'] as String,
    checkUserRealName: json['check_user_real_name'] as String,
  );
}

Map<String, dynamic> _$DeviceCheckedAlarmMessageToJson(
        DeviceCheckedAlarmMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'device_name': instance.deviceName,
      'record_time': timeToJson(instance.recordTime),
      'device_code': instance.deviceCode,
      'checked': instance.checked,
      'engine_code': instance.engineCode,
      'id': instance.id,
      'check_user_id': instance.checkUserId,
      'warning_message_id': instance.warningMessageId,
      'fault_type': instance.faultType,
      'check_time': instance.checkTIme,
      'check_user_real_name': instance.checkUserRealName,
    };

PageDataModel _$PageDataModelFromJson(Map<String, dynamic> json) {
  return PageDataModel(
    dataList: json['content'] as List,
    totalPage: json['total_pages'] as int,
    currentPage: json['number'] as int,
  );
}

Map<String, dynamic> _$PageDataModelToJson(PageDataModel instance) =>
    <String, dynamic>{
      'content': instance.dataList,
      'total_pages': instance.totalPage,
      'number': instance.currentPage,
    };

PersonnelMessage _$PersonnelMessageFromJson(Map<String, dynamic> json) {
  return PersonnelMessage(
    id: json['id'] as String,
    name: json['real_name'] as String,
    roleType: json['role_type'] as String,
    enable: json['enable'] as bool,
    mobile: json['mobile'] as String,
  );
}

Map<String, dynamic> _$PersonnelMessageToJson(PersonnelMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'real_name': instance.name,
      'mobile': instance.mobile,
      'role_type': instance.roleType,
      'enable': instance.enable,
    };

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
  TaskStatus.unreached: 'unreached',
  TaskStatus.running: 'running',
  TaskStatus.out_time_completed: 'out_time_completed',
};

Build _$BuildFromJson(Map<String, dynamic> json) {
  return Build(
    buildName: json['name'] as String,
    floors: (json['floors'] as List)
        ?.map((e) =>
            e == null ? null : FloorEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..aboveFloorNum = json['above_floor_num'] as String
    ..acreage = json['acreage'] as String
    ..addressDetail = json['address_detail'] as String
    ..area = json['area'] as String
    ..buildDate = json['build_date'] as String
    ..city = json['city'] as String
    ..danger = json['danger'] as String
    ..description = json['description'] as String
    ..mainEngineCode = json['main_engine_code'] as String
    ..nature = json['nature'] as String
    ..province = json['province'] as String
    ..refractory = json['refractory'] as String
    ..type = json['type'] as String
    ..underFloorNum = json['under_floor_num'] as String;
}

Map<String, dynamic> _$BuildToJson(Build instance) => <String, dynamic>{
      'name': instance.buildName,
      'floors': instance.floors,
      'above_floor_num': instance.aboveFloorNum,
      'acreage': instance.acreage,
      'address_detail': instance.addressDetail,
      'area': instance.area,
      'build_date': instance.buildDate,
      'city': instance.city,
      'danger': instance.danger,
      'description': instance.description,
      'main_engine_code': instance.mainEngineCode,
      'nature': instance.nature,
      'province': instance.province,
      'refractory': instance.refractory,
      'type': instance.type,
      'under_floor_num': instance.underFloorNum,
    };

FloorEntity _$FloorEntityFromJson(Map<String, dynamic> json) {
  return FloorEntity(
    code: json['code'] as String,
    name: json['name'] as String,
    id: json['id'] as String,
    length: json['length'] as String,
    width: json['width'] as String,
    picture: json['picture'] as String,
  );
}

Map<String, dynamic> _$FloorEntityToJson(FloorEntity instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'name': instance.name,
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  writeNotNull('width', instance.width);
  writeNotNull('picture', instance.picture);
  return val;
}

DeviceMessage _$DeviceMessageFromJson(Map<String, dynamic> json) {
  return DeviceMessage(
    area: json['area'] as String,
    category: json['category'] as String,
    code: json['code'] as String,
    floor: json['floor'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    online: json['is_online'] as bool,
    position: json['position'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$DeviceMessageToJson(DeviceMessage instance) =>
    <String, dynamic>{
      'area': instance.area,
      'category': instance.category,
      'code': instance.code,
      'floor': instance.floor,
      'id': instance.id,
      'name': instance.name,
      'is_online': instance.online,
      'position': instance.position,
      'status': instance.status,
    };

DeclareMessage _$DeclareMessageFromJson(Map<String, dynamic> json) {
  return DeclareMessage(
    id: json['id'] as String,
    title: json['title'] as String,
    comment: json['comment'] as String,
    deviceList: json['device_list'] as List,
    postUserId: json['post_user_id'] as int,
    checkedUserId: json['checked_user_id'] as int,
    checked: json['checked'] as bool,
  );
}

Map<String, dynamic> _$DeclareMessageToJson(DeclareMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'comment': instance.comment,
      'device_list': instance.deviceList,
      'post_user_id': instance.postUserId,
      'checked_user_id': instance.checkedUserId,
      'checked': instance.checked,
    };

FloorDeviceModel _$FloorDeviceModelFromJson(Map<String, dynamic> json) {
  return FloorDeviceModel(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    categoryName: json['category_name'] as String,
    categoryCode: json['category_code'] as String,
    xposition: json['xposition'] as String,
    yposition: json['yposition'] as String,
    position: json['position'] as String,
  );
}

Map<String, dynamic> _$FloorDeviceModelToJson(FloorDeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'category_name': instance.categoryName,
      'category_code': instance.categoryCode,
      'xposition': instance.xposition,
      'yposition': instance.yposition,
      'position': instance.position,
    };

LoginUserInfo _$LoginUserInfoFromJson(Map<String, dynamic> json) {
  return LoginUserInfo(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginUserInfoToJson(LoginUserInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
