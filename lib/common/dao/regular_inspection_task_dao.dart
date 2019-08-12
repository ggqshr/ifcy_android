import 'dart:convert';

///@author ggq
///@description: 日常巡检任务的数据持久化层
///@date :2019/8/12 13:21
import 'package:moor_flutter/moor_flutter.dart';
import 'package:ifcy/common/model/model.dart';
import 'dart:async';

part 'regular_inspection_task_dao.g.dart';

class RegularInspectionTaskDetailEntry extends Table {
  TextColumn get deviceId => text()();

  TextColumn get deviceName => text()();

  TextColumn get deviceType => text()();

  TextColumn get inspectionRequire => text()();

  TextColumn get inspectionResultType => text()();

  TextColumn get processType => text()();

  TextColumn get noteText => text()();

  TextColumn get images => text().nullable()();

  TextColumn get taskStatus => text()();

  TextColumn get taskArea => text()();

  TextColumn get taskFloor => text()();

  TextColumn get taskId => text()(); //任务的ID
}

///数据库类，用来装载本地的巡检任务的任务详情的一些数据操作
@UseMoor(tables: [RegularInspectionTaskDetailEntry])
class RITaskDetailDatabase extends _$RITaskDetailDatabase {
  RITaskDetailDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'RITaskDetailDatabase.db'));

  @override
  int get schemaVersion => 1;

  Future<int> addTaskDetail(RegularInspectionTaskDetailEntryCompanion entry) {
    return into(regularInspectionTaskDetailEntry).insert(entry);
  }

  Future<List<RegularInspectionTaskDetailEntryData>> getTaskDetailList() {
    return select(regularInspectionTaskDetailEntry).get();
  }

  Future<int> addTaskDetails(List<RegularInspectionTaskDetail> list) {
    var addList = list.map((item) {
      //todo taskid加入到实体类，现在正在写批量插入的部分
      return RegularInspectionTaskDetailEntryData(
        deviceName: item.deviceName,
        deviceId: item.deviceId,
        deviceType: item.deviceType,
        inspectionRequire: item.inspectionRequire,
        inspectionResultType: parseEnumType(item.inspectionResultType),
        processType: parseEnumType(item.processType),
        noteText: item.noteText,
        images: jsonEncode(item.images),
        taskStatus: parseEnumType(item.taskStatus),
        taskArea: item.taskArea,
        taskFloor: item.taskFloor,
      );
    }).toList();
    into(regularInspectionTaskDetailEntry).insertAll(addList);
  }
}
