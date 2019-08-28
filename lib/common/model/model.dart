library models;

import 'dart:math';
import 'dart:io';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
part 'model.g.dart';
part 'fire_alarm_message.dart';

part 'device_fault_message.dart';

part 'task_info_message.dart';

part 'personnel_message.dart';

part 'supervisior_message.dart';

part 'regular_inspection_task.dart';

part 'fault_inspection_task.dart';

part 'offline_device_fault_message.dart';

part 'online_device_fault_sured_message.dart';

part 'online_device_fault_unsrued_message.dart';

part 'processed_device_fault_message.dart';

part 'processing_device_fault_message.dart';

part 'building_floor_message.dart';

part 'inspection_system.dart';


part 'build.dart';

///检查结果的类型
enum InspectionResultType {
  normal, //正常
  defect, //缺陷
  fault, //故障
}

Map<int, String> inspectionResultTypeMap = {
  0: "正常",
  1: "缺陷",
  2: "故障",
};

///根据传入的类型，将枚举类和字符串互转
parseEnumType<S>(S type) {
  if (!(type is String)) {
    if (type is InspectionResultType) {
      return inspectionResultTypeMap[InspectionResultType.values.indexOf(type)];
    } else if (type is ProcessType) {
      return processTypeMap[ProcessType.values.indexOf(type)];
    } else if (type is TaskStatus) {
      return taskStatusEnumMap[TaskStatus.values.indexOf(type)];
    } else if (type is NewInspectionType) {
      return newInspectionTypeTypeMap[NewInspectionType.values.indexOf(type)];
    }
  } else {
    if (inspectionResultTypeMap.containsValue(type as String)) {
      int thisIndex = inspectionResultTypeMap.keys.toList()[
          inspectionResultTypeMap.values.toList().indexOf(type as String)];
      return InspectionResultType.values[thisIndex];
    } else if (processTypeMap.containsValue(type as String)) {
      int thisIndex = processTypeMap.keys
          .toList()[processTypeMap.values.toList().indexOf(type as String)];
      return ProcessType.values[thisIndex];
    } else if (taskStatusEnumMap.containsValue(type as String)) {
      int thisIndex = taskStatusEnumMap.keys
          .toList()[taskStatusEnumMap.values.toList().indexOf(type as String)];
      return TaskStatus.values[thisIndex];
    } else if (newInspectionTypeTypeMap.containsValue(type as String)) {
      int thisIndex = newInspectionTypeTypeMap.keys.toList()[
          newInspectionTypeTypeMap.values.toList().indexOf(type as String)];
      return NewInspectionType.values[thisIndex];
    }
  }
}

///处理措施
enum ProcessType {
  repair, //现场维修
  requireChange, //申请更换
  requireRepair, //申报维修
}

Map<int, String> processTypeMap = {
  0: "现场维修",
  1: "申请更换",
  2: "申报维修",
};

abstract class TaskInfo {
  String id; //任务id
  String taskTitle; //任务标题
  String taskPeople; //任务执行人
  String taskContent; //任务内容
  String taskTime; //任务时间限制
  TaskStatus taskStatus; //任务执行状态，分为是否执行完毕

  TaskInfo({
    this.id,
    this.taskTitle,
    this.taskPeople,
    this.taskContent,
    this.taskTime,
    this.taskStatus,
  });

  String toPrint(String className) {
    return '$className{id: $id, taskTitle: $taskTitle, taskPeople: $taskPeople, taskContent: $taskContent, taskTime: $taskTime, taskStatus: $taskStatus}';
  }
}

///故障消息的抽象类
abstract class FaultInfo {
  String id; //故障消息id
  String deviceName; //故障设备名称
  String deviceType; //故障设备类型
  String deviceLocation; //故障设备位置
  String alarmTimeFirst; //线上设备首次报警时间
  String alarmTimeLast; //线上设备最后一次报警时间
  String deviceFaultTime; //设备故障时间
  String excutor; //线上设备故障确认者

  FaultInfo({
    this.id,
    this.deviceName,
    this.deviceType,
    this.deviceLocation,
    this.alarmTimeFirst,
    this.alarmTimeLast,
    this.deviceFaultTime,
    this.excutor,
  });

  String toPrint(String className) {
    return '$className{id:$id,deviceName:$deviceName,deviceType:$deviceType,deviceLocation:$deviceLocation,alarmTimeFirst:$alarmTimeFirst,alarmTimeLast:$alarmTimeLast,deviceFaultTime:$deviceFaultTime,excutor:$excutor}';
  }
}

enum FaultStatus {
  sured, //确定故障
  unSured, //待确定
}

abstract class TaskInfoDetail {
  String deviceName; //设备名
  String deviceId; //设备ID
  String deviceType; //设备类别
  String inspectionRequire; //检查要求
  InspectionResultType inspectionResultType; //检查结果的类型
  ProcessType processType; //处理的措施
  String noteText; //备注
  @JsonKey(ignore: true)
  List<String> images; //上传的图片的文件名
  TaskStatus taskStatus; //任务的状态，是否完成
  String taskArea; //设备的区域
  String taskFloor; //设备的楼层信息
  bool isUpload; //是否已经上传到云端

  TaskInfoDetail(
      {this.deviceName,
      this.deviceId,
      this.deviceType,
      this.inspectionRequire,
      this.inspectionResultType,
      this.processType,
      this.noteText,
      this.images,
      this.taskStatus,
      this.taskArea,
      this.taskFloor,
      this.isUpload});

  TaskInfoDetail.fromDao(RegularInspectionTaskDetailEntryData data)
      : deviceName = data.deviceName,
        deviceId = data.deviceId,
        deviceType = data.deviceType,
        inspectionRequire = data.inspectionRequire,
        inspectionResultType = parseEnumType(data.inspectionResultType),
        processType = parseEnumType(data.processType),
        noteText = data.noteText,
        images = jsonDecode(
          data.images,
        ).cast<String>(),
        taskStatus = parseEnumType(data.taskStatus),
        taskArea = data.taskArea,
        taskFloor = data.taskFloor,
        isUpload = data.isUpload;

  void changeUploadStatus(bool status) {
    isUpload = status;
  }

  void updateTaskStatus(TaskStatus status);

  String toPrint(String className) {
    return '$className{deviceName: $deviceName, deviceId: $deviceId, deviceType: $deviceType, inspectionRequire: $inspectionRequire, inspectionResultType: $inspectionResultType, processType: $processType, noteText: $noteText, images: $images, taskStatus: $taskStatus, taskArea: $taskArea, taskFloor: $taskFloor, isUpload: $isUpload}';
  }
}

class TaskInfoDetailListBloc<T extends TaskInfoDetail> with ChangeNotifier {
  String taskId; //用来标识是哪个任务
  List<T> taskDetailList; //装载所有数据的列表
  List<T> list2show; //页面上用来渲染的列表
  Set<T> list2upload; // 扫码以后等待上传和服务器同步的列表
  TaskStatus currentShowTaskStatus; //当前要显示的任务详情列表的状态，用来筛选
  List<bool> areaSelected; //当前选中的区域
  String currentFloor; //当前选择的楼层
  String currentDeviceType; //当前选择的设备类型
  List<T> afterTypeFilter; //经过完成类型过滤的数据
  List<T> afterFloorFilter; //经过楼层过滤的数据
  List<T> afterAreaFilter; //经过区域过滤的数据
  List<T> afterDeviceTypeFilter; //经过设备类型过滤的数据
  RITaskDetailDatabase db = RITaskDetailDatabase();

  //当前过滤当中该区域是否有设备需要检查
  List<bool> get areaEnable {
    var temp = List.generate(12, (_) => false);
    for (var item in currentAreaList) {
      temp[int.parse(item)] = true;
    }
    return temp;
  }

  //当前显示的任务详情的所有区域
  Set<String> get currentAreaList => afterFloorFilter
      .toSet()
      .intersection(afterTypeFilter.toSet())
      .map((item) => item.taskArea)
      .toSet();

  //经过类型筛选后的所有楼层
  List<String> get currentFloorList => afterTypeFilter
      .toSet()
      .intersection(taskDetailList.toSet())
      .toList()
      .map((item) => item.taskFloor)
      .toSet()
      .toList();

  //经过任务类型以及楼层和区域选择之后的设备类型列表
  List<String> get currentDeviceTypeList => afterAreaFilter
      .toSet()
      .intersection(afterFloorFilter.toSet())
      .intersection(afterTypeFilter.toSet())
      .map((item) => item.deviceType)
      .toSet()
      .toList();

  //获取当前所有任务中执行完成的任务列表
  List<T> get currentCompleteTask => taskDetailList
      .where((item) => item.taskStatus == TaskStatus.completed)
      .toList();

  //获取当前所有任务中未执行完成的任务列表
  List<T> get currentUnCompleteTask => taskDetailList
      .where((item) => item.taskStatus == TaskStatus.uncompleted)
      .toList();

  TaskInfoDetailListBloc.localInit(String taskId) {
    this.taskId = taskId;
    list2upload = {};
    taskDetailList = [];
    list2show = taskDetailList;
    afterAreaFilter = taskDetailList;
    afterFloorFilter = taskDetailList;
    afterTypeFilter = taskDetailList;
    areaSelected = List.generate(12, (_) => false);
    currentFloor = "空";
    currentDeviceType = "空";
    _localInit(taskId);
  }

  void _localInit(String taskId) async {
//    List tt1 = await db.getTaskDetailList(taskId);
//    if(tt1.isEmpty){
//      db.addTaskDetails("1", List.generate(20, (index) {
//        return RegularInspectionTaskDetail.generate(index.toString());
//      }));
//    }
    List tt = await db.getTaskDetailList(taskId);
    tt = tt.map((item) => RegularInspectionTaskDetail.fromDao(item)).toList();
    this.taskDetailList = tt;
    list2show = taskDetailList;
    afterAreaFilter = taskDetailList;
    afterFloorFilter = taskDetailList;
    afterTypeFilter = taskDetailList;
    list2upload = taskDetailList
        .where((item) =>
            item.isUpload != null &&
            !item.isUpload &&
            item.taskStatus == TaskStatus.uncompleted)
        .toSet(); //将未完成的，且上传状态为false的项目加入到待上传列表中
    areaSelected = List.generate(12, (_) => false);
    currentFloor = "空";
    currentDeviceType = "空";
    notifyListeners();
  }

  //将任务添加到待上传列表
  void addUploadItem(T taskDetail) {
    taskDetail.changeUploadStatus(false); //默认的上传状态为null,只有扫码时，将上传状态改为false
    list2upload.add(taskDetail);
    notifyListeners();
  }

  void filterByTaskStatus(TaskStatus taskStatus) {
    afterTypeFilter = taskDetailList.where((item) {
      return item.taskStatus == taskStatus;
    }).toList();
  }

  //更改选中显示的任务状态
  void changeTaskStatusByIndex(TaskStatus status) {
    currentShowTaskStatus = status;
    if (status == null) {
      afterTypeFilter = taskDetailList;
    } else {
      filterByTaskStatus(status);
    }
    currentFloor = "空";
    afterFloorFilter = taskDetailList;
    currentDeviceType = "空";
    afterDeviceTypeFilter = taskDetailList;
    notifyListeners();
  }

  //改变当前的楼层
  void changeFloor(String value) {
    currentFloor = value;
    if (value == "空") {
      afterFloorFilter = taskDetailList;
    } else {
      afterFloorFilter = afterTypeFilter.where((item) {
        return item.taskFloor == currentFloor;
      }).toList();
    }
    currentDeviceType = "空";
    afterDeviceTypeFilter = taskDetailList;
    notifyListeners();
  }

  //更改选中区域
  void changeAreaSelected(int index, bool value) {
    areaSelected[index] = value; //更新当前的区域选择数据
    //如果当前有区域是激活的，但是一个都没选择，那么确认时就默认选全部
    if (areaEnable.any((item) => item) && areaSelected.every((item) => !item)) {
      afterAreaFilter = taskDetailList;
    } else {
      afterAreaFilter = afterFloorFilter.where((item) {
        var thisArea = int.parse(item.taskArea);
        return areaSelected[thisArea] & areaEnable[thisArea];
      }).toList();
    }
    currentDeviceType = "空";
    afterDeviceTypeFilter = taskDetailList;
    notifyListeners();
  }

  void changeDeviceType(String value) {
    currentDeviceType = value;
    if (value == "空") {
      afterDeviceTypeFilter = taskDetailList;
    } else {
      afterDeviceTypeFilter = afterTypeFilter.where((item) {
        return item.deviceType == currentDeviceType;
      }).toList();
    }
    notifyListeners();
  }

  //应用当前的筛选条件
  void applyFilter() {
    list2show = afterTypeFilter
        .toSet()
        .intersection(afterFloorFilter.toSet())
        .intersection(afterAreaFilter.toSet())
        .intersection(afterDeviceTypeFilter.toSet())
        .toList();
    notifyListeners();
  }

  //重置所有条件
  void resetFilter() {
    currentShowTaskStatus = null;
    afterAreaFilter = taskDetailList;
    afterFloorFilter = taskDetailList;
    afterTypeFilter = taskDetailList;
    afterDeviceTypeFilter = taskDetailList;
    areaSelected = List.generate(12, (_) => false);
    currentFloor = "空";
    currentDeviceType = "空";
    notifyListeners();
  }

  ///将待上传列表中的项目上传到服务器
  ///上传的同时，将任务的上传状态改为已上传，同时将该设备的缓存中的图片改为服务器返回的图片名
  ///同时，在上传成功之后，将设备从待上传列表中删除
  Future<void> upload2server() async {
    for (var device in list2upload) {
      //todo 上传到服务器，并更改图片的文件名
      device.changeUploadStatus(true); //将上传状态更新
      device.taskStatus = TaskStatus.completed; //将任务状态更新
      await Future.delayed(Duration(seconds: 1));
      await db.updateDeviceStatus(taskId, device); //将数据库中的数据更新
    }
    //全部上传完成后，将列表清空
    list2upload.clear();
    notifyListeners();
  }
}
