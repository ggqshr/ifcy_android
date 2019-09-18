// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class RegularInspectionTaskDetailEntryData extends DataClass
    implements Insertable<RegularInspectionTaskDetailEntryData> {
  final String deviceId;
  final String deviceName;
  final String deviceType;
  final String inspectionRequire;
  final String inspectionResultType;
  final String processType;
  final String noteText;
  final String images;
  final String taskStatus;
  final String taskArea;
  final String taskFloor;
  final String taskId;
  final bool isUpload;
  RegularInspectionTaskDetailEntryData(
      {@required this.deviceId,
      @required this.deviceName,
      @required this.deviceType,
      @required this.inspectionRequire,
      @required this.inspectionResultType,
      @required this.processType,
      @required this.noteText,
      this.images,
      @required this.taskStatus,
      @required this.taskArea,
      @required this.taskFloor,
      @required this.taskId,
      @required this.isUpload});
  factory RegularInspectionTaskDetailEntryData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return RegularInspectionTaskDetailEntryData(
      deviceId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_id']),
      deviceName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_name']),
      deviceType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_type']),
      inspectionRequire: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}inspection_require']),
      inspectionResultType: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}inspection_result_type']),
      processType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}process_type']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
      images:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images']),
      taskStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_status']),
      taskArea: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_area']),
      taskFloor: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_floor']),
      taskId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}task_id']),
      isUpload:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_upload']),
    );
  }
  factory RegularInspectionTaskDetailEntryData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return RegularInspectionTaskDetailEntryData(
      deviceId: serializer.fromJson<String>(json['deviceId']),
      deviceName: serializer.fromJson<String>(json['deviceName']),
      deviceType: serializer.fromJson<String>(json['deviceType']),
      inspectionRequire: serializer.fromJson<String>(json['inspectionRequire']),
      inspectionResultType:
          serializer.fromJson<String>(json['inspectionResultType']),
      processType: serializer.fromJson<String>(json['processType']),
      noteText: serializer.fromJson<String>(json['noteText']),
      images: serializer.fromJson<String>(json['images']),
      taskStatus: serializer.fromJson<String>(json['taskStatus']),
      taskArea: serializer.fromJson<String>(json['taskArea']),
      taskFloor: serializer.fromJson<String>(json['taskFloor']),
      taskId: serializer.fromJson<String>(json['taskId']),
      isUpload: serializer.fromJson<bool>(json['isUpload']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'deviceId': serializer.toJson<String>(deviceId),
      'deviceName': serializer.toJson<String>(deviceName),
      'deviceType': serializer.toJson<String>(deviceType),
      'inspectionRequire': serializer.toJson<String>(inspectionRequire),
      'inspectionResultType': serializer.toJson<String>(inspectionResultType),
      'processType': serializer.toJson<String>(processType),
      'noteText': serializer.toJson<String>(noteText),
      'images': serializer.toJson<String>(images),
      'taskStatus': serializer.toJson<String>(taskStatus),
      'taskArea': serializer.toJson<String>(taskArea),
      'taskFloor': serializer.toJson<String>(taskFloor),
      'taskId': serializer.toJson<String>(taskId),
      'isUpload': serializer.toJson<bool>(isUpload),
    };
  }

  @override
  T createCompanion<
          T extends UpdateCompanion<RegularInspectionTaskDetailEntryData>>(
      bool nullToAbsent) {
    return RegularInspectionTaskDetailEntryCompanion(
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      deviceName: deviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceName),
      deviceType: deviceType == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceType),
      inspectionRequire: inspectionRequire == null && nullToAbsent
          ? const Value.absent()
          : Value(inspectionRequire),
      inspectionResultType: inspectionResultType == null && nullToAbsent
          ? const Value.absent()
          : Value(inspectionResultType),
      processType: processType == null && nullToAbsent
          ? const Value.absent()
          : Value(processType),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
      images:
          images == null && nullToAbsent ? const Value.absent() : Value(images),
      taskStatus: taskStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(taskStatus),
      taskArea: taskArea == null && nullToAbsent
          ? const Value.absent()
          : Value(taskArea),
      taskFloor: taskFloor == null && nullToAbsent
          ? const Value.absent()
          : Value(taskFloor),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      isUpload: isUpload == null && nullToAbsent
          ? const Value.absent()
          : Value(isUpload),
    ) as T;
  }

  RegularInspectionTaskDetailEntryData copyWith(
          {String deviceId,
          String deviceName,
          String deviceType,
          String inspectionRequire,
          String inspectionResultType,
          String processType,
          String noteText,
          String images,
          String taskStatus,
          String taskArea,
          String taskFloor,
          String taskId,
          bool isUpload}) =>
      RegularInspectionTaskDetailEntryData(
        deviceId: deviceId ?? this.deviceId,
        deviceName: deviceName ?? this.deviceName,
        deviceType: deviceType ?? this.deviceType,
        inspectionRequire: inspectionRequire ?? this.inspectionRequire,
        inspectionResultType: inspectionResultType ?? this.inspectionResultType,
        processType: processType ?? this.processType,
        noteText: noteText ?? this.noteText,
        images: images ?? this.images,
        taskStatus: taskStatus ?? this.taskStatus,
        taskArea: taskArea ?? this.taskArea,
        taskFloor: taskFloor ?? this.taskFloor,
        taskId: taskId ?? this.taskId,
        isUpload: isUpload ?? this.isUpload,
      );
  @override
  String toString() {
    return (StringBuffer('RegularInspectionTaskDetailEntryData(')
          ..write('deviceId: $deviceId, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceType: $deviceType, ')
          ..write('inspectionRequire: $inspectionRequire, ')
          ..write('inspectionResultType: $inspectionResultType, ')
          ..write('processType: $processType, ')
          ..write('noteText: $noteText, ')
          ..write('images: $images, ')
          ..write('taskStatus: $taskStatus, ')
          ..write('taskArea: $taskArea, ')
          ..write('taskFloor: $taskFloor, ')
          ..write('taskId: $taskId, ')
          ..write('isUpload: $isUpload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      deviceId.hashCode,
      $mrjc(
          deviceName.hashCode,
          $mrjc(
              deviceType.hashCode,
              $mrjc(
                  inspectionRequire.hashCode,
                  $mrjc(
                      inspectionResultType.hashCode,
                      $mrjc(
                          processType.hashCode,
                          $mrjc(
                              noteText.hashCode,
                              $mrjc(
                                  images.hashCode,
                                  $mrjc(
                                      taskStatus.hashCode,
                                      $mrjc(
                                          taskArea.hashCode,
                                          $mrjc(
                                              taskFloor.hashCode,
                                              $mrjc(
                                                  taskId.hashCode,
                                                  isUpload
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is RegularInspectionTaskDetailEntryData &&
          other.deviceId == deviceId &&
          other.deviceName == deviceName &&
          other.deviceType == deviceType &&
          other.inspectionRequire == inspectionRequire &&
          other.inspectionResultType == inspectionResultType &&
          other.processType == processType &&
          other.noteText == noteText &&
          other.images == images &&
          other.taskStatus == taskStatus &&
          other.taskArea == taskArea &&
          other.taskFloor == taskFloor &&
          other.taskId == taskId &&
          other.isUpload == isUpload);
}

class RegularInspectionTaskDetailEntryCompanion
    extends UpdateCompanion<RegularInspectionTaskDetailEntryData> {
  final Value<String> deviceId;
  final Value<String> deviceName;
  final Value<String> deviceType;
  final Value<String> inspectionRequire;
  final Value<String> inspectionResultType;
  final Value<String> processType;
  final Value<String> noteText;
  final Value<String> images;
  final Value<String> taskStatus;
  final Value<String> taskArea;
  final Value<String> taskFloor;
  final Value<String> taskId;
  final Value<bool> isUpload;
  const RegularInspectionTaskDetailEntryCompanion({
    this.deviceId = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.deviceType = const Value.absent(),
    this.inspectionRequire = const Value.absent(),
    this.inspectionResultType = const Value.absent(),
    this.processType = const Value.absent(),
    this.noteText = const Value.absent(),
    this.images = const Value.absent(),
    this.taskStatus = const Value.absent(),
    this.taskArea = const Value.absent(),
    this.taskFloor = const Value.absent(),
    this.taskId = const Value.absent(),
    this.isUpload = const Value.absent(),
  });
  RegularInspectionTaskDetailEntryCompanion copyWith(
      {Value<String> deviceId,
      Value<String> deviceName,
      Value<String> deviceType,
      Value<String> inspectionRequire,
      Value<String> inspectionResultType,
      Value<String> processType,
      Value<String> noteText,
      Value<String> images,
      Value<String> taskStatus,
      Value<String> taskArea,
      Value<String> taskFloor,
      Value<String> taskId,
      Value<bool> isUpload}) {
    return RegularInspectionTaskDetailEntryCompanion(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      deviceType: deviceType ?? this.deviceType,
      inspectionRequire: inspectionRequire ?? this.inspectionRequire,
      inspectionResultType: inspectionResultType ?? this.inspectionResultType,
      processType: processType ?? this.processType,
      noteText: noteText ?? this.noteText,
      images: images ?? this.images,
      taskStatus: taskStatus ?? this.taskStatus,
      taskArea: taskArea ?? this.taskArea,
      taskFloor: taskFloor ?? this.taskFloor,
      taskId: taskId ?? this.taskId,
      isUpload: isUpload ?? this.isUpload,
    );
  }
}

class $RegularInspectionTaskDetailEntryTable
    extends RegularInspectionTaskDetailEntry
    with
        TableInfo<$RegularInspectionTaskDetailEntryTable,
            RegularInspectionTaskDetailEntryData> {
  final GeneratedDatabase _db;
  final String _alias;
  $RegularInspectionTaskDetailEntryTable(this._db, [this._alias]);
  final VerificationMeta _deviceIdMeta = const VerificationMeta('deviceId');
  GeneratedTextColumn _deviceId;
  @override
  GeneratedTextColumn get deviceId => _deviceId ??= _constructDeviceId();
  GeneratedTextColumn _constructDeviceId() {
    return GeneratedTextColumn(
      'device_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deviceNameMeta = const VerificationMeta('deviceName');
  GeneratedTextColumn _deviceName;
  @override
  GeneratedTextColumn get deviceName => _deviceName ??= _constructDeviceName();
  GeneratedTextColumn _constructDeviceName() {
    return GeneratedTextColumn(
      'device_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deviceTypeMeta = const VerificationMeta('deviceType');
  GeneratedTextColumn _deviceType;
  @override
  GeneratedTextColumn get deviceType => _deviceType ??= _constructDeviceType();
  GeneratedTextColumn _constructDeviceType() {
    return GeneratedTextColumn(
      'device_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _inspectionRequireMeta =
      const VerificationMeta('inspectionRequire');
  GeneratedTextColumn _inspectionRequire;
  @override
  GeneratedTextColumn get inspectionRequire =>
      _inspectionRequire ??= _constructInspectionRequire();
  GeneratedTextColumn _constructInspectionRequire() {
    return GeneratedTextColumn(
      'inspection_require',
      $tableName,
      false,
    );
  }

  final VerificationMeta _inspectionResultTypeMeta =
      const VerificationMeta('inspectionResultType');
  GeneratedTextColumn _inspectionResultType;
  @override
  GeneratedTextColumn get inspectionResultType =>
      _inspectionResultType ??= _constructInspectionResultType();
  GeneratedTextColumn _constructInspectionResultType() {
    return GeneratedTextColumn(
      'inspection_result_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _processTypeMeta =
      const VerificationMeta('processType');
  GeneratedTextColumn _processType;
  @override
  GeneratedTextColumn get processType =>
      _processType ??= _constructProcessType();
  GeneratedTextColumn _constructProcessType() {
    return GeneratedTextColumn(
      'process_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _noteTextMeta = const VerificationMeta('noteText');
  GeneratedTextColumn _noteText;
  @override
  GeneratedTextColumn get noteText => _noteText ??= _constructNoteText();
  GeneratedTextColumn _constructNoteText() {
    return GeneratedTextColumn(
      'note_text',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taskStatusMeta = const VerificationMeta('taskStatus');
  GeneratedTextColumn _taskStatus;
  @override
  GeneratedTextColumn get taskStatus => _taskStatus ??= _constructTaskStatus();
  GeneratedTextColumn _constructTaskStatus() {
    return GeneratedTextColumn(
      'task_status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskAreaMeta = const VerificationMeta('taskArea');
  GeneratedTextColumn _taskArea;
  @override
  GeneratedTextColumn get taskArea => _taskArea ??= _constructTaskArea();
  GeneratedTextColumn _constructTaskArea() {
    return GeneratedTextColumn(
      'task_area',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskFloorMeta = const VerificationMeta('taskFloor');
  GeneratedTextColumn _taskFloor;
  @override
  GeneratedTextColumn get taskFloor => _taskFloor ??= _constructTaskFloor();
  GeneratedTextColumn _constructTaskFloor() {
    return GeneratedTextColumn(
      'task_floor',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  GeneratedTextColumn _taskId;
  @override
  GeneratedTextColumn get taskId => _taskId ??= _constructTaskId();
  GeneratedTextColumn _constructTaskId() {
    return GeneratedTextColumn(
      'task_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isUploadMeta = const VerificationMeta('isUpload');
  GeneratedBoolColumn _isUpload;
  @override
  GeneratedBoolColumn get isUpload => _isUpload ??= _constructIsUpload();
  GeneratedBoolColumn _constructIsUpload() {
    return GeneratedBoolColumn(
      'is_upload',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        deviceId,
        deviceName,
        deviceType,
        inspectionRequire,
        inspectionResultType,
        processType,
        noteText,
        images,
        taskStatus,
        taskArea,
        taskFloor,
        taskId,
        isUpload
      ];
  @override
  $RegularInspectionTaskDetailEntryTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'regular_inspection_task_detail_entry';
  @override
  final String actualTableName = 'regular_inspection_task_detail_entry';
  @override
  VerificationContext validateIntegrity(
      RegularInspectionTaskDetailEntryCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.deviceId.present) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableValue(d.deviceId.value, _deviceIdMeta));
    } else if (deviceId.isRequired && isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (d.deviceName.present) {
      context.handle(_deviceNameMeta,
          deviceName.isAcceptableValue(d.deviceName.value, _deviceNameMeta));
    } else if (deviceName.isRequired && isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (d.deviceType.present) {
      context.handle(_deviceTypeMeta,
          deviceType.isAcceptableValue(d.deviceType.value, _deviceTypeMeta));
    } else if (deviceType.isRequired && isInserting) {
      context.missing(_deviceTypeMeta);
    }
    if (d.inspectionRequire.present) {
      context.handle(
          _inspectionRequireMeta,
          inspectionRequire.isAcceptableValue(
              d.inspectionRequire.value, _inspectionRequireMeta));
    } else if (inspectionRequire.isRequired && isInserting) {
      context.missing(_inspectionRequireMeta);
    }
    if (d.inspectionResultType.present) {
      context.handle(
          _inspectionResultTypeMeta,
          inspectionResultType.isAcceptableValue(
              d.inspectionResultType.value, _inspectionResultTypeMeta));
    } else if (inspectionResultType.isRequired && isInserting) {
      context.missing(_inspectionResultTypeMeta);
    }
    if (d.processType.present) {
      context.handle(_processTypeMeta,
          processType.isAcceptableValue(d.processType.value, _processTypeMeta));
    } else if (processType.isRequired && isInserting) {
      context.missing(_processTypeMeta);
    }
    if (d.noteText.present) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableValue(d.noteText.value, _noteTextMeta));
    } else if (noteText.isRequired && isInserting) {
      context.missing(_noteTextMeta);
    }
    if (d.images.present) {
      context.handle(
          _imagesMeta, images.isAcceptableValue(d.images.value, _imagesMeta));
    } else if (images.isRequired && isInserting) {
      context.missing(_imagesMeta);
    }
    if (d.taskStatus.present) {
      context.handle(_taskStatusMeta,
          taskStatus.isAcceptableValue(d.taskStatus.value, _taskStatusMeta));
    } else if (taskStatus.isRequired && isInserting) {
      context.missing(_taskStatusMeta);
    }
    if (d.taskArea.present) {
      context.handle(_taskAreaMeta,
          taskArea.isAcceptableValue(d.taskArea.value, _taskAreaMeta));
    } else if (taskArea.isRequired && isInserting) {
      context.missing(_taskAreaMeta);
    }
    if (d.taskFloor.present) {
      context.handle(_taskFloorMeta,
          taskFloor.isAcceptableValue(d.taskFloor.value, _taskFloorMeta));
    } else if (taskFloor.isRequired && isInserting) {
      context.missing(_taskFloorMeta);
    }
    if (d.taskId.present) {
      context.handle(
          _taskIdMeta, taskId.isAcceptableValue(d.taskId.value, _taskIdMeta));
    } else if (taskId.isRequired && isInserting) {
      context.missing(_taskIdMeta);
    }
    if (d.isUpload.present) {
      context.handle(_isUploadMeta,
          isUpload.isAcceptableValue(d.isUpload.value, _isUploadMeta));
    } else if (isUpload.isRequired && isInserting) {
      context.missing(_isUploadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  RegularInspectionTaskDetailEntryData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RegularInspectionTaskDetailEntryData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(
      RegularInspectionTaskDetailEntryCompanion d) {
    final map = <String, Variable>{};
    if (d.deviceId.present) {
      map['device_id'] = Variable<String, StringType>(d.deviceId.value);
    }
    if (d.deviceName.present) {
      map['device_name'] = Variable<String, StringType>(d.deviceName.value);
    }
    if (d.deviceType.present) {
      map['device_type'] = Variable<String, StringType>(d.deviceType.value);
    }
    if (d.inspectionRequire.present) {
      map['inspection_require'] =
          Variable<String, StringType>(d.inspectionRequire.value);
    }
    if (d.inspectionResultType.present) {
      map['inspection_result_type'] =
          Variable<String, StringType>(d.inspectionResultType.value);
    }
    if (d.processType.present) {
      map['process_type'] = Variable<String, StringType>(d.processType.value);
    }
    if (d.noteText.present) {
      map['note_text'] = Variable<String, StringType>(d.noteText.value);
    }
    if (d.images.present) {
      map['images'] = Variable<String, StringType>(d.images.value);
    }
    if (d.taskStatus.present) {
      map['task_status'] = Variable<String, StringType>(d.taskStatus.value);
    }
    if (d.taskArea.present) {
      map['task_area'] = Variable<String, StringType>(d.taskArea.value);
    }
    if (d.taskFloor.present) {
      map['task_floor'] = Variable<String, StringType>(d.taskFloor.value);
    }
    if (d.taskId.present) {
      map['task_id'] = Variable<String, StringType>(d.taskId.value);
    }
    if (d.isUpload.present) {
      map['is_upload'] = Variable<bool, BoolType>(d.isUpload.value);
    }
    return map;
  }

  @override
  $RegularInspectionTaskDetailEntryTable createAlias(String alias) {
    return $RegularInspectionTaskDetailEntryTable(_db, alias);
  }
}

abstract class _$RITaskDetailDatabase extends GeneratedDatabase {
  _$RITaskDetailDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $RegularInspectionTaskDetailEntryTable _regularInspectionTaskDetailEntry;
  $RegularInspectionTaskDetailEntryTable get regularInspectionTaskDetailEntry =>
      _regularInspectionTaskDetailEntry ??=
          $RegularInspectionTaskDetailEntryTable(this);
  @override
  List<TableInfo> get allTables => [regularInspectionTaskDetailEntry];
}

// ignore_for_file: unnecessary_brace_in_string_interps
class DeviceData extends DataClass implements Insertable<DeviceData> {
  final String taskId;
  final String name;
  final String id;
  final String code;
  final String comment;
  final String checkStatus;
  final String checkResult;
  final String buildingFloorId;
  final String images;
  DeviceData(
      {@required this.taskId,
      @required this.name,
      @required this.id,
      @required this.code,
      this.comment,
      @required this.checkStatus,
      @required this.checkResult,
      @required this.buildingFloorId,
      this.images});
  factory DeviceData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return DeviceData(
      taskId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}task_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      code: stringType.mapFromDatabaseResponse(data['${effectivePrefix}code']),
      comment:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}comment']),
      checkStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}check_status']),
      checkResult: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}check_result']),
      buildingFloorId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}building_floor_id']),
      images:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images']),
    );
  }
  factory DeviceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return DeviceData(
      taskId: serializer.fromJson<String>(json['taskId']),
      name: serializer.fromJson<String>(json['name']),
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      comment: serializer.fromJson<String>(json['comment']),
      checkStatus: serializer.fromJson<String>(json['checkStatus']),
      checkResult: serializer.fromJson<String>(json['checkResult']),
      buildingFloorId: serializer.fromJson<String>(json['buildingFloorId']),
      images: serializer.fromJson<String>(json['images']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'taskId': serializer.toJson<String>(taskId),
      'name': serializer.toJson<String>(name),
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'comment': serializer.toJson<String>(comment),
      'checkStatus': serializer.toJson<String>(checkStatus),
      'checkResult': serializer.toJson<String>(checkResult),
      'buildingFloorId': serializer.toJson<String>(buildingFloorId),
      'images': serializer.toJson<String>(images),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<DeviceData>>(bool nullToAbsent) {
    return DeviceCompanion(
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      checkStatus: checkStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(checkStatus),
      checkResult: checkResult == null && nullToAbsent
          ? const Value.absent()
          : Value(checkResult),
      buildingFloorId: buildingFloorId == null && nullToAbsent
          ? const Value.absent()
          : Value(buildingFloorId),
      images:
          images == null && nullToAbsent ? const Value.absent() : Value(images),
    ) as T;
  }

  DeviceData copyWith(
          {String taskId,
          String name,
          String id,
          String code,
          String comment,
          String checkStatus,
          String checkResult,
          String buildingFloorId,
          String images}) =>
      DeviceData(
        taskId: taskId ?? this.taskId,
        name: name ?? this.name,
        id: id ?? this.id,
        code: code ?? this.code,
        comment: comment ?? this.comment,
        checkStatus: checkStatus ?? this.checkStatus,
        checkResult: checkResult ?? this.checkResult,
        buildingFloorId: buildingFloorId ?? this.buildingFloorId,
        images: images ?? this.images,
      );
  @override
  String toString() {
    return (StringBuffer('DeviceData(')
          ..write('taskId: $taskId, ')
          ..write('name: $name, ')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('comment: $comment, ')
          ..write('checkStatus: $checkStatus, ')
          ..write('checkResult: $checkResult, ')
          ..write('buildingFloorId: $buildingFloorId, ')
          ..write('images: $images')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      taskId.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              id.hashCode,
              $mrjc(
                  code.hashCode,
                  $mrjc(
                      comment.hashCode,
                      $mrjc(
                          checkStatus.hashCode,
                          $mrjc(
                              checkResult.hashCode,
                              $mrjc(buildingFloorId.hashCode,
                                  images.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is DeviceData &&
          other.taskId == taskId &&
          other.name == name &&
          other.id == id &&
          other.code == code &&
          other.comment == comment &&
          other.checkStatus == checkStatus &&
          other.checkResult == checkResult &&
          other.buildingFloorId == buildingFloorId &&
          other.images == images);
}

class DeviceCompanion extends UpdateCompanion<DeviceData> {
  final Value<String> taskId;
  final Value<String> name;
  final Value<String> id;
  final Value<String> code;
  final Value<String> comment;
  final Value<String> checkStatus;
  final Value<String> checkResult;
  final Value<String> buildingFloorId;
  final Value<String> images;
  const DeviceCompanion({
    this.taskId = const Value.absent(),
    this.name = const Value.absent(),
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.comment = const Value.absent(),
    this.checkStatus = const Value.absent(),
    this.checkResult = const Value.absent(),
    this.buildingFloorId = const Value.absent(),
    this.images = const Value.absent(),
  });
  DeviceCompanion copyWith(
      {Value<String> taskId,
      Value<String> name,
      Value<String> id,
      Value<String> code,
      Value<String> comment,
      Value<String> checkStatus,
      Value<String> checkResult,
      Value<String> buildingFloorId,
      Value<String> images}) {
    return DeviceCompanion(
      taskId: taskId ?? this.taskId,
      name: name ?? this.name,
      id: id ?? this.id,
      code: code ?? this.code,
      comment: comment ?? this.comment,
      checkStatus: checkStatus ?? this.checkStatus,
      checkResult: checkResult ?? this.checkResult,
      buildingFloorId: buildingFloorId ?? this.buildingFloorId,
      images: images ?? this.images,
    );
  }
}

class $DeviceTable extends Device with TableInfo<$DeviceTable, DeviceData> {
  final GeneratedDatabase _db;
  final String _alias;
  $DeviceTable(this._db, [this._alias]);
  final VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  GeneratedTextColumn _taskId;
  @override
  GeneratedTextColumn get taskId => _taskId ??= _constructTaskId();
  GeneratedTextColumn _constructTaskId() {
    return GeneratedTextColumn(
      'task_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _codeMeta = const VerificationMeta('code');
  GeneratedTextColumn _code;
  @override
  GeneratedTextColumn get code => _code ??= _constructCode();
  GeneratedTextColumn _constructCode() {
    return GeneratedTextColumn(
      'code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  GeneratedTextColumn _comment;
  @override
  GeneratedTextColumn get comment => _comment ??= _constructComment();
  GeneratedTextColumn _constructComment() {
    return GeneratedTextColumn(
      'comment',
      $tableName,
      true,
    );
  }

  final VerificationMeta _checkStatusMeta =
      const VerificationMeta('checkStatus');
  GeneratedTextColumn _checkStatus;
  @override
  GeneratedTextColumn get checkStatus =>
      _checkStatus ??= _constructCheckStatus();
  GeneratedTextColumn _constructCheckStatus() {
    return GeneratedTextColumn(
      'check_status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _checkResultMeta =
      const VerificationMeta('checkResult');
  GeneratedTextColumn _checkResult;
  @override
  GeneratedTextColumn get checkResult =>
      _checkResult ??= _constructCheckResult();
  GeneratedTextColumn _constructCheckResult() {
    return GeneratedTextColumn(
      'check_result',
      $tableName,
      false,
    );
  }

  final VerificationMeta _buildingFloorIdMeta =
      const VerificationMeta('buildingFloorId');
  GeneratedTextColumn _buildingFloorId;
  @override
  GeneratedTextColumn get buildingFloorId =>
      _buildingFloorId ??= _constructBuildingFloorId();
  GeneratedTextColumn _constructBuildingFloorId() {
    return GeneratedTextColumn(
      'building_floor_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        taskId,
        name,
        id,
        code,
        comment,
        checkStatus,
        checkResult,
        buildingFloorId,
        images
      ];
  @override
  $DeviceTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'device';
  @override
  final String actualTableName = 'device';
  @override
  VerificationContext validateIntegrity(DeviceCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.taskId.present) {
      context.handle(
          _taskIdMeta, taskId.isAcceptableValue(d.taskId.value, _taskIdMeta));
    } else if (taskId.isRequired && isInserting) {
      context.missing(_taskIdMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.code.present) {
      context.handle(
          _codeMeta, code.isAcceptableValue(d.code.value, _codeMeta));
    } else if (code.isRequired && isInserting) {
      context.missing(_codeMeta);
    }
    if (d.comment.present) {
      context.handle(_commentMeta,
          comment.isAcceptableValue(d.comment.value, _commentMeta));
    } else if (comment.isRequired && isInserting) {
      context.missing(_commentMeta);
    }
    if (d.checkStatus.present) {
      context.handle(_checkStatusMeta,
          checkStatus.isAcceptableValue(d.checkStatus.value, _checkStatusMeta));
    } else if (checkStatus.isRequired && isInserting) {
      context.missing(_checkStatusMeta);
    }
    if (d.checkResult.present) {
      context.handle(_checkResultMeta,
          checkResult.isAcceptableValue(d.checkResult.value, _checkResultMeta));
    } else if (checkResult.isRequired && isInserting) {
      context.missing(_checkResultMeta);
    }
    if (d.buildingFloorId.present) {
      context.handle(
          _buildingFloorIdMeta,
          buildingFloorId.isAcceptableValue(
              d.buildingFloorId.value, _buildingFloorIdMeta));
    } else if (buildingFloorId.isRequired && isInserting) {
      context.missing(_buildingFloorIdMeta);
    }
    if (d.images.present) {
      context.handle(
          _imagesMeta, images.isAcceptableValue(d.images.value, _imagesMeta));
    } else if (images.isRequired && isInserting) {
      context.missing(_imagesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DeviceData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DeviceData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DeviceCompanion d) {
    final map = <String, Variable>{};
    if (d.taskId.present) {
      map['task_id'] = Variable<String, StringType>(d.taskId.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.code.present) {
      map['code'] = Variable<String, StringType>(d.code.value);
    }
    if (d.comment.present) {
      map['comment'] = Variable<String, StringType>(d.comment.value);
    }
    if (d.checkStatus.present) {
      map['check_status'] = Variable<String, StringType>(d.checkStatus.value);
    }
    if (d.checkResult.present) {
      map['check_result'] = Variable<String, StringType>(d.checkResult.value);
    }
    if (d.buildingFloorId.present) {
      map['building_floor_id'] =
          Variable<String, StringType>(d.buildingFloorId.value);
    }
    if (d.images.present) {
      map['images'] = Variable<String, StringType>(d.images.value);
    }
    return map;
  }

  @override
  $DeviceTable createAlias(String alias) {
    return $DeviceTable(_db, alias);
  }
}

abstract class _$DeviceDB extends GeneratedDatabase {
  _$DeviceDB(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $DeviceTable _device;
  $DeviceTable get device => _device ??= $DeviceTable(this);
  @override
  List<TableInfo> get allTables => [device];
}
