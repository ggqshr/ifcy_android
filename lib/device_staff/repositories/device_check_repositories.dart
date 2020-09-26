import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/common/utils/cache_manager.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';

///@author ggq
///@description:
///@date :2019/8/31 10:00
class DeviceCheckDataProvider {
  final String taskId;
  final DeviceDB _db = DeviceDB();

  DeviceCheckDataProvider(
    taskId,
  ) : taskId = taskId;

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

  Future<Map> uploadToServer(Map map) async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.patch(
      "/patrol/task/$taskId/check-device",
      data: FormData.from(map),
    );
    return res.data['data'];
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
  Future uploadDevice(List<InspectionDeviceModel> models) async {
    for (var model in models) {
      Map dataMap = model.toJson();
      List<UploadFileInfo> pics = [];
      //从缓存中读取图片，并转化成上传的对象
      for (var key in ["pic1", "pic2"]) {
        if (dataMap[key] != null) {
          File pic = await IfcyCacheManager().getSingleFile(dataMap[key]);
          pics.add(UploadFileInfo(pic, dataMap[key],
              contentType: ContentType.parse("image/jpeg")));
          dataMap.remove(key); //删除不需要的字段
        }
      }
      dataMap['pics'] = pics;
      Map fileNames = await provider.uploadToServer(dataMap);
      if (model.pic1 != null && model.pic2 != null) {
        ///如果两个图片都不空
        model.pic1 = await resetCacheImage(fileNames, model.pic1, "pic1");
        model.pic2 = await resetCacheImage(fileNames, model.pic2, "pic2");
      } else {
        //如果返回的数据中第一个图片不空
        if (fileNames['pic1'] != null) {
          if (model.pic1 == null) {
            //如果本地第一个为空，那么将返回的文件名付给第二个图片
            model.pic2 = await resetCacheImage(fileNames, model.pic2, "pic1");
          } else if (model.pic1 != null) {
            //如果本地的第一个不空，那么将返回的文件名付给第一个
            model.pic1 = await resetCacheImage(fileNames, model.pic1, "pic1");
          }
        }
      }
      model.checkStatus = CheckStatus.checked;
      await provider.updateLocal(model);
    }
  }

  Future<String> resetCacheImage(
      Map fileNames, String fileName, String keyName) async {
    File pic = await IfcyCacheManager().getSingleFile(fileName); //拿到第一张图片
    String newFileName = fileNames[keyName];
    await IfcyCacheManager().putFile(newFileName, await pic.readAsBytes());
    IfcyCacheManager().removeFile(fileName); //删除第一张图片
    return newFileName;
  }
}
