///@author ggq
///@description:
///@date :2019/8/30 20:27
part of "dao.dart";

class Device extends Table {
  TextColumn get taskId => text()();

  TextColumn get name => text()();

  TextColumn get id => text()();

  TextColumn get code => text()();

  TextColumn get comment => text().nullable()();

  TextColumn get checkStatus => text()();

  TextColumn get checkResult => text()();

  TextColumn get buildingFloorId => text()();

  TextColumn get images => text().nullable()();

  TextColumn get xPosition => text().nullable()();

  TextColumn get yPosition => text().nullable()();
}

@UseMoor(tables: [Device])
class DeviceDB extends _$DeviceDB {
  DeviceDB()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'device.sqlite'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAllTables();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          // we added the dueDate property in the change from version 1
          await m.addColumn(device, device.xPosition);
          await m.addColumn(device, device.yPosition);
        }
      }
  );

  ///获取本地化的所有设备列表
  Stream<List<InspectionDeviceModel>> getDevices(String taskId) {
    return (select(device)..where((t) => t.taskId.equals(taskId))).watch().map(
        (items) => items
            .map((item) => InspectionDeviceModel.fromData(item)
              ..checkResult = CheckResult.running)
            .toList());
  }

  ///根据taskId以及设备Id更新本地的状态
  Future<int> updateLocal(DeviceData data) async {
    return await (update(device)
          ..where(
              (t) => and(t.taskId.equals(data.taskId), t.id.equals(data.id))))
        .write(DeviceCompanion(
      comment: Value(data.comment),
      checkStatus: Value(data.checkStatus),
      checkResult: Value(data.checkResult),
      images: Value(data.images),
    ));
  }

  ///插入所有的设备记录，用于第一次请求列表时
  Future<void> insertDevices(List<DeviceData> datas) async {
    await into(device).insertAll(datas);
  }

  ///获取本地存储的设备列表的长度，用于判断是否做持久化
  Future<int> getLocalListLen(String taskId) async {
    var lists =
        await (select(device)..where((t) => t.taskId.equals(taskId))).get();
    return lists.length;
  }

  ///删除本地所有的记录，将新纪录插入
  Future deleteAndUpdate(String taskId, List<DeviceData> datas) async {
    return transaction((_) async {
      await (delete(device)..where((i) => i.taskId.equals(taskId))).go();
      await insertDevices(datas);
    });
  }
}
