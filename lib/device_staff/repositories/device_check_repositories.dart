import 'package:flutter/cupertino.dart';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';

///@author ggq
///@description:
///@date :2019/8/31 10:00
class DeviceCheckDataProvider {
  final String taskId;
  final DeviceDB _db;

  DeviceCheckDataProvider(taskId, [db])
      : _db = db ?? DeviceDB(),
        taskId = taskId;

  ///查看本地是否有缓存的数据
  Future<int> getLocalLen() async {
    return await _db.getLocalListLen(taskId);
  }

  Future<int> updateLocal(InspectionDeviceModel model) async {
    return await _db.updateLocal(model.toData(taskId));
  }

  Stream<List<InspectionDeviceModel>> getDeviceLocal() =>
      _db.getDevices(taskId);

  Future<void> insertIntoDb(List<InspectionDeviceModel> models) async {
    List<DeviceData> datas = models.map((item) => item.toData(taskId)).toList();
    await _db.insertDevices(datas);
  }

  Future deleteAndUpdate(List<InspectionDeviceModel> models) async {
    List<DeviceData> datas = models.map((item) => item.toData(taskId)).toList();
    await _db.deleteAndUpdate(taskId, datas);
  }
}

class DeviceCheckRepositories {
  final String taskId;
  final DeviceCheckDataProvider provider;

  DeviceCheckRepositories(this.taskId, [provider])
      : provider = provider ?? DeviceCheckDataProvider(taskId);

  Stream<List<InspectionDeviceModel>> get deviceList =>
      provider.getDeviceLocal();

  ///打开列表时进行本地初始化或者和服务器同步
  Future updateLocal(List<InspectionDeviceModel> models) async {
    int localLen = await provider.getLocalLen();
    if (localLen == 0 || localLen == null) {
      //如果本地没有，将所有的数据插入到本地
      await provider.insertIntoDb(models);
    } else {
      if (localLen == models.length) {
        //没有设备的增加，直接把服务器上的已检查任务同步到本地
        for (var item
            in models.where((i) => i.checkStatus == CheckStatus.checked)) {
          await provider.updateLocal(item);
        }
      } else if (localLen != models.length) {
        await provider.deleteAndUpdate(models);
      }
    }
  }

  ///更新单个设备
  Future<int> updateDevice(InspectionDeviceModel model) async {
    return await provider.updateLocal(model);
  }

  ///和服务器进行同步
  Future uploadDevice(List<InspectionDeviceModel> models) async {}
}
