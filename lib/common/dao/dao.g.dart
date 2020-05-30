// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || deviceName != null) {
      map['device_name'] = Variable<String>(deviceName);
    }
    if (!nullToAbsent || deviceType != null) {
      map['device_type'] = Variable<String>(deviceType);
    }
    if (!nullToAbsent || inspectionRequire != null) {
      map['inspection_require'] = Variable<String>(inspectionRequire);
    }
    if (!nullToAbsent || inspectionResultType != null) {
      map['inspection_result_type'] = Variable<String>(inspectionResultType);
    }
    if (!nullToAbsent || processType != null) {
      map['process_type'] = Variable<String>(processType);
    }
    if (!nullToAbsent || noteText != null) {
      map['note_text'] = Variable<String>(noteText);
    }
    if (!nullToAbsent || images != null) {
      map['images'] = Variable<String>(images);
    }
    if (!nullToAbsent || taskStatus != null) {
      map['task_status'] = Variable<String>(taskStatus);
    }
    if (!nullToAbsent || taskArea != null) {
      map['task_area'] = Variable<String>(taskArea);
    }
    if (!nullToAbsent || taskFloor != null) {
      map['task_floor'] = Variable<String>(taskFloor);
    }
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    if (!nullToAbsent || isUpload != null) {
      map['is_upload'] = Variable<bool>(isUpload);
    }
    return map;
  }

  RegularInspectionTaskDetailEntryCompanion toCompanion(bool nullToAbsent) {
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
    );
  }

  factory RegularInspectionTaskDetailEntryData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
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
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RegularInspectionTaskDetailEntryData &&
          other.deviceId == this.deviceId &&
          other.deviceName == this.deviceName &&
          other.deviceType == this.deviceType &&
          other.inspectionRequire == this.inspectionRequire &&
          other.inspectionResultType == this.inspectionResultType &&
          other.processType == this.processType &&
          other.noteText == this.noteText &&
          other.images == this.images &&
          other.taskStatus == this.taskStatus &&
          other.taskArea == this.taskArea &&
          other.taskFloor == this.taskFloor &&
          other.taskId == this.taskId &&
          other.isUpload == this.isUpload);
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
  RegularInspectionTaskDetailEntryCompanion.insert({
    @required String deviceId,
    @required String deviceName,
    @required String deviceType,
    @required String inspectionRequire,
    @required String inspectionResultType,
    @required String processType,
    @required String noteText,
    this.images = const Value.absent(),
    @required String taskStatus,
    @required String taskArea,
    @required String taskFloor,
    @required String taskId,
    @required bool isUpload,
  })  : deviceId = Value(deviceId),
        deviceName = Value(deviceName),
        deviceType = Value(deviceType),
        inspectionRequire = Value(inspectionRequire),
        inspectionResultType = Value(inspectionResultType),
        processType = Value(processType),
        noteText = Value(noteText),
        taskStatus = Value(taskStatus),
        taskArea = Value(taskArea),
        taskFloor = Value(taskFloor),
        taskId = Value(taskId),
        isUpload = Value(isUpload);
  static Insertable<RegularInspectionTaskDetailEntryData> custom({
    Expression<String> deviceId,
    Expression<String> deviceName,
    Expression<String> deviceType,
    Expression<String> inspectionRequire,
    Expression<String> inspectionResultType,
    Expression<String> processType,
    Expression<String> noteText,
    Expression<String> images,
    Expression<String> taskStatus,
    Expression<String> taskArea,
    Expression<String> taskFloor,
    Expression<String> taskId,
    Expression<bool> isUpload,
  }) {
    return RawValuesInsertable({
      if (deviceId != null) 'device_id': deviceId,
      if (deviceName != null) 'device_name': deviceName,
      if (deviceType != null) 'device_type': deviceType,
      if (inspectionRequire != null) 'inspection_require': inspectionRequire,
      if (inspectionResultType != null)
        'inspection_result_type': inspectionResultType,
      if (processType != null) 'process_type': processType,
      if (noteText != null) 'note_text': noteText,
      if (images != null) 'images': images,
      if (taskStatus != null) 'task_status': taskStatus,
      if (taskArea != null) 'task_area': taskArea,
      if (taskFloor != null) 'task_floor': taskFloor,
      if (taskId != null) 'task_id': taskId,
      if (isUpload != null) 'is_upload': isUpload,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (deviceType.present) {
      map['device_type'] = Variable<String>(deviceType.value);
    }
    if (inspectionRequire.present) {
      map['inspection_require'] = Variable<String>(inspectionRequire.value);
    }
    if (inspectionResultType.present) {
      map['inspection_result_type'] =
          Variable<String>(inspectionResultType.value);
    }
    if (processType.present) {
      map['process_type'] = Variable<String>(processType.value);
    }
    if (noteText.present) {
      map['note_text'] = Variable<String>(noteText.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    if (taskStatus.present) {
      map['task_status'] = Variable<String>(taskStatus.value);
    }
    if (taskArea.present) {
      map['task_area'] = Variable<String>(taskArea.value);
    }
    if (taskFloor.present) {
      map['task_floor'] = Variable<String>(taskFloor.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (isUpload.present) {
      map['is_upload'] = Variable<bool>(isUpload.value);
    }
    return map;
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
      Insertable<RegularInspectionTaskDetailEntryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id'], _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
          _deviceNameMeta,
          deviceName.isAcceptableOrUnknown(
              data['device_name'], _deviceNameMeta));
    } else if (isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (data.containsKey('device_type')) {
      context.handle(
          _deviceTypeMeta,
          deviceType.isAcceptableOrUnknown(
              data['device_type'], _deviceTypeMeta));
    } else if (isInserting) {
      context.missing(_deviceTypeMeta);
    }
    if (data.containsKey('inspection_require')) {
      context.handle(
          _inspectionRequireMeta,
          inspectionRequire.isAcceptableOrUnknown(
              data['inspection_require'], _inspectionRequireMeta));
    } else if (isInserting) {
      context.missing(_inspectionRequireMeta);
    }
    if (data.containsKey('inspection_result_type')) {
      context.handle(
          _inspectionResultTypeMeta,
          inspectionResultType.isAcceptableOrUnknown(
              data['inspection_result_type'], _inspectionResultTypeMeta));
    } else if (isInserting) {
      context.missing(_inspectionResultTypeMeta);
    }
    if (data.containsKey('process_type')) {
      context.handle(
          _processTypeMeta,
          processType.isAcceptableOrUnknown(
              data['process_type'], _processTypeMeta));
    } else if (isInserting) {
      context.missing(_processTypeMeta);
    }
    if (data.containsKey('note_text')) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableOrUnknown(data['note_text'], _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images'], _imagesMeta));
    }
    if (data.containsKey('task_status')) {
      context.handle(
          _taskStatusMeta,
          taskStatus.isAcceptableOrUnknown(
              data['task_status'], _taskStatusMeta));
    } else if (isInserting) {
      context.missing(_taskStatusMeta);
    }
    if (data.containsKey('task_area')) {
      context.handle(_taskAreaMeta,
          taskArea.isAcceptableOrUnknown(data['task_area'], _taskAreaMeta));
    } else if (isInserting) {
      context.missing(_taskAreaMeta);
    }
    if (data.containsKey('task_floor')) {
      context.handle(_taskFloorMeta,
          taskFloor.isAcceptableOrUnknown(data['task_floor'], _taskFloorMeta));
    } else if (isInserting) {
      context.missing(_taskFloorMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id'], _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('is_upload')) {
      context.handle(_isUploadMeta,
          isUpload.isAcceptableOrUnknown(data['is_upload'], _isUploadMeta));
    } else if (isInserting) {
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
  $RegularInspectionTaskDetailEntryTable createAlias(String alias) {
    return $RegularInspectionTaskDetailEntryTable(_db, alias);
  }
}

abstract class _$RITaskDetailDatabase extends GeneratedDatabase {
  _$RITaskDetailDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $RegularInspectionTaskDetailEntryTable _regularInspectionTaskDetailEntry;
  $RegularInspectionTaskDetailEntryTable get regularInspectionTaskDetailEntry =>
      _regularInspectionTaskDetailEntry ??=
          $RegularInspectionTaskDetailEntryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [regularInspectionTaskDetailEntry];
}

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
  final String xPosition;
  final String yPosition;
  DeviceData(
      {@required this.taskId,
      @required this.name,
      @required this.id,
      @required this.code,
      this.comment,
      @required this.checkStatus,
      @required this.checkResult,
      @required this.buildingFloorId,
      this.images,
      this.xPosition,
      this.yPosition});
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
      xPosition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}x_position']),
      yPosition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}y_position']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || checkStatus != null) {
      map['check_status'] = Variable<String>(checkStatus);
    }
    if (!nullToAbsent || checkResult != null) {
      map['check_result'] = Variable<String>(checkResult);
    }
    if (!nullToAbsent || buildingFloorId != null) {
      map['building_floor_id'] = Variable<String>(buildingFloorId);
    }
    if (!nullToAbsent || images != null) {
      map['images'] = Variable<String>(images);
    }
    if (!nullToAbsent || xPosition != null) {
      map['x_position'] = Variable<String>(xPosition);
    }
    if (!nullToAbsent || yPosition != null) {
      map['y_position'] = Variable<String>(yPosition);
    }
    return map;
  }

  DeviceCompanion toCompanion(bool nullToAbsent) {
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
      xPosition: xPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(xPosition),
      yPosition: yPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(yPosition),
    );
  }

  factory DeviceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
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
      xPosition: serializer.fromJson<String>(json['xPosition']),
      yPosition: serializer.fromJson<String>(json['yPosition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'name': serializer.toJson<String>(name),
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'comment': serializer.toJson<String>(comment),
      'checkStatus': serializer.toJson<String>(checkStatus),
      'checkResult': serializer.toJson<String>(checkResult),
      'buildingFloorId': serializer.toJson<String>(buildingFloorId),
      'images': serializer.toJson<String>(images),
      'xPosition': serializer.toJson<String>(xPosition),
      'yPosition': serializer.toJson<String>(yPosition),
    };
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
          String images,
          String xPosition,
          String yPosition}) =>
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
        xPosition: xPosition ?? this.xPosition,
        yPosition: yPosition ?? this.yPosition,
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
          ..write('images: $images, ')
          ..write('xPosition: $xPosition, ')
          ..write('yPosition: $yPosition')
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
                              $mrjc(
                                  buildingFloorId.hashCode,
                                  $mrjc(
                                      images.hashCode,
                                      $mrjc(xPosition.hashCode,
                                          yPosition.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DeviceData &&
          other.taskId == this.taskId &&
          other.name == this.name &&
          other.id == this.id &&
          other.code == this.code &&
          other.comment == this.comment &&
          other.checkStatus == this.checkStatus &&
          other.checkResult == this.checkResult &&
          other.buildingFloorId == this.buildingFloorId &&
          other.images == this.images &&
          other.xPosition == this.xPosition &&
          other.yPosition == this.yPosition);
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
  final Value<String> xPosition;
  final Value<String> yPosition;
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
    this.xPosition = const Value.absent(),
    this.yPosition = const Value.absent(),
  });
  DeviceCompanion.insert({
    @required String taskId,
    @required String name,
    @required String id,
    @required String code,
    this.comment = const Value.absent(),
    @required String checkStatus,
    @required String checkResult,
    @required String buildingFloorId,
    this.images = const Value.absent(),
    this.xPosition = const Value.absent(),
    this.yPosition = const Value.absent(),
  })  : taskId = Value(taskId),
        name = Value(name),
        id = Value(id),
        code = Value(code),
        checkStatus = Value(checkStatus),
        checkResult = Value(checkResult),
        buildingFloorId = Value(buildingFloorId);
  static Insertable<DeviceData> custom({
    Expression<String> taskId,
    Expression<String> name,
    Expression<String> id,
    Expression<String> code,
    Expression<String> comment,
    Expression<String> checkStatus,
    Expression<String> checkResult,
    Expression<String> buildingFloorId,
    Expression<String> images,
    Expression<String> xPosition,
    Expression<String> yPosition,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (name != null) 'name': name,
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (comment != null) 'comment': comment,
      if (checkStatus != null) 'check_status': checkStatus,
      if (checkResult != null) 'check_result': checkResult,
      if (buildingFloorId != null) 'building_floor_id': buildingFloorId,
      if (images != null) 'images': images,
      if (xPosition != null) 'x_position': xPosition,
      if (yPosition != null) 'y_position': yPosition,
    });
  }

  DeviceCompanion copyWith(
      {Value<String> taskId,
      Value<String> name,
      Value<String> id,
      Value<String> code,
      Value<String> comment,
      Value<String> checkStatus,
      Value<String> checkResult,
      Value<String> buildingFloorId,
      Value<String> images,
      Value<String> xPosition,
      Value<String> yPosition}) {
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
      xPosition: xPosition ?? this.xPosition,
      yPosition: yPosition ?? this.yPosition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (checkStatus.present) {
      map['check_status'] = Variable<String>(checkStatus.value);
    }
    if (checkResult.present) {
      map['check_result'] = Variable<String>(checkResult.value);
    }
    if (buildingFloorId.present) {
      map['building_floor_id'] = Variable<String>(buildingFloorId.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    if (xPosition.present) {
      map['x_position'] = Variable<String>(xPosition.value);
    }
    if (yPosition.present) {
      map['y_position'] = Variable<String>(yPosition.value);
    }
    return map;
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

  final VerificationMeta _xPositionMeta = const VerificationMeta('xPosition');
  GeneratedTextColumn _xPosition;
  @override
  GeneratedTextColumn get xPosition => _xPosition ??= _constructXPosition();
  GeneratedTextColumn _constructXPosition() {
    return GeneratedTextColumn(
      'x_position',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yPositionMeta = const VerificationMeta('yPosition');
  GeneratedTextColumn _yPosition;
  @override
  GeneratedTextColumn get yPosition => _yPosition ??= _constructYPosition();
  GeneratedTextColumn _constructYPosition() {
    return GeneratedTextColumn(
      'y_position',
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
        images,
        xPosition,
        yPosition
      ];
  @override
  $DeviceTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'device';
  @override
  final String actualTableName = 'device';
  @override
  VerificationContext validateIntegrity(Insertable<DeviceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id'], _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code'], _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment'], _commentMeta));
    }
    if (data.containsKey('check_status')) {
      context.handle(
          _checkStatusMeta,
          checkStatus.isAcceptableOrUnknown(
              data['check_status'], _checkStatusMeta));
    } else if (isInserting) {
      context.missing(_checkStatusMeta);
    }
    if (data.containsKey('check_result')) {
      context.handle(
          _checkResultMeta,
          checkResult.isAcceptableOrUnknown(
              data['check_result'], _checkResultMeta));
    } else if (isInserting) {
      context.missing(_checkResultMeta);
    }
    if (data.containsKey('building_floor_id')) {
      context.handle(
          _buildingFloorIdMeta,
          buildingFloorId.isAcceptableOrUnknown(
              data['building_floor_id'], _buildingFloorIdMeta));
    } else if (isInserting) {
      context.missing(_buildingFloorIdMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images'], _imagesMeta));
    }
    if (data.containsKey('x_position')) {
      context.handle(_xPositionMeta,
          xPosition.isAcceptableOrUnknown(data['x_position'], _xPositionMeta));
    }
    if (data.containsKey('y_position')) {
      context.handle(_yPositionMeta,
          yPosition.isAcceptableOrUnknown(data['y_position'], _yPositionMeta));
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
  $DeviceTable createAlias(String alias) {
    return $DeviceTable(_db, alias);
  }
}

abstract class _$DeviceDB extends GeneratedDatabase {
  _$DeviceDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $DeviceTable _device;
  $DeviceTable get device => _device ??= $DeviceTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [device];
}
