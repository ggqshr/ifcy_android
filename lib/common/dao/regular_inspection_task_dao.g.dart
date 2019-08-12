// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_inspection_task_dao.dart';

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
      @required this.taskId});
  factory RegularInspectionTaskDetailEntryData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
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
          String taskId}) =>
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
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc(
                                      $mrjc(
                                          $mrjc($mrjc(0, deviceId.hashCode),
                                              deviceName.hashCode),
                                          deviceType.hashCode),
                                      inspectionRequire.hashCode),
                                  inspectionResultType.hashCode),
                              processType.hashCode),
                          noteText.hashCode),
                      images.hashCode),
                  taskStatus.hashCode),
              taskArea.hashCode),
          taskFloor.hashCode),
      taskId.hashCode));
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
          other.taskId == taskId);
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
  });
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
        taskId
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
