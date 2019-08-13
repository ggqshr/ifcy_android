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

  BoolColumn get isUpload => boolean()();
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

  //根据任务id查询该任务需要检查的设备
  Future<List<RegularInspectionTaskDetailEntryData>> getTaskDetailList(
      String taskId) {
    return (select(regularInspectionTaskDetailEntry)
          ..where((item) => item.taskId.equals(taskId)))
        .get();
  }

  /// 将任务列表插入到数据库中，根据[taskId]来标识是属于哪一个任务的
  Future<void> addTaskDetails(
      String taskId, List<RegularInspectionTaskDetail> list) {
    var addList = list.map((item) {
      //todo taskid加入到实体类，现在正在写批量插入的部分
      return RegularInspectionTaskDetailEntryData(
        taskId: taskId,
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
        isUpload: item.isUpload,
      );
    }).toList();
    return into(regularInspectionTaskDetailEntry).insertAll(addList);
  }

  ///根据任务id，以及设备id更新某个设备的执行状态，图像名称，备注文字，处理的方式以及检查的结果
  Future<int> updateDeviceStatus(
      String taskId, RegularInspectionTaskDetail task) {
    return (update(regularInspectionTaskDetailEntry)
          ..where((item) => and(
              item.taskId.equals(taskId), item.deviceId.equals(task.deviceId))))
        .write(RegularInspectionTaskDetailEntryCompanion(
      deviceName: Value.absent(),
      deviceId: Value.absent(),
      deviceType: Value.absent(),
      inspectionRequire: Value.absent(),
      taskArea: Value.absent(),
      taskFloor: Value.absent(),
      taskStatus: Value(parseEnumType(task.taskStatus)),
      images: Value(jsonEncode(task.images)),
      noteText: Value(task.noteText),
      processType: Value(parseEnumType(task.processType)),
      inspectionResultType: Value(
        parseEnumType(task.inspectionResultType),
      ),
      isUpload: Value(task.isUpload),
    ));
  }
}
