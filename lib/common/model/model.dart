export 'fire_alarm_message.dart';
export 'device_fault_message.dart';
export 'task_info_message.dart';
export 'regular_inspection_task.dart';
export 'additional_inspection_task.dart';
export 'fault_inspection_task.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ifcy/common/model/task_info_message.dart';

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

abstract class TaskInfoDetail {
  String deviceName; //设备名
  String deviceId; //设备ID
  String deviceType; //设备类别
  String inspectionRequire; //检查要求
  InspectionResultType inspectionResultType; //检查结果的类型
  ProcessType processType; //处理的措施
  String noteText; //备注
  List<File> images; //上传的图片
  TaskStatus taskStatus; //任务的状态，是否完成
  String taskArea; //设备的区域
  String taskFloor; //设备的楼层信息

  TaskInfoDetail({
    this.deviceName,
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
  });

  String toPrint(String className) {
    return '$className{deviceName: $deviceName, deviceId: $deviceId, deviceType: $deviceType, inspectionRequire: $inspectionRequire, inspectionResultType: $inspectionResultType, processType: $processType, noteText: $noteText, images: $images, taskStatus: $taskStatus, taskArea: $taskArea, taskFloor: $taskFloor}';
  }
}

class TaskInfoDetailListBloc<T extends TaskInfoDetail> with ChangeNotifier {
  List<T> taskDetailList; //装载所有数据的列表
  List<T> list2show; //页面上用来渲染的列表
  TaskStatus currentShowTaskStatus; //当前要显示的任务详情列表的状态，用来筛选
  List<bool> areaSelected; //当前选中的区域
  String currentFloor; //当前选择的楼层
  List<T> afterTypeFilter; //经过完成类型过滤的数据
  List<T> afterFloorFilter; //经过楼层过滤的数据
  List<T> afterAreaFilter; //经过区域过滤的数据

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

  //获取当前所有任务中执行完成的任务列表
  List<T> get currentCompleteTask => taskDetailList
      .where((item) => item.taskStatus == TaskStatus.completed)
      .toList();

  //获取当前所有任务中未执行完成的任务列表
  List<T> get currentUnCompleteTask => taskDetailList
      .where((item) => item.taskStatus == TaskStatus.uncompleted)
      .toList();

  TaskInfoDetailListBloc.localInit(List<T> taskDetailList) {
    this.taskDetailList = taskDetailList;
    list2show = taskDetailList;
    afterAreaFilter = taskDetailList;
    afterFloorFilter = taskDetailList;
    afterTypeFilter = taskDetailList;
    areaSelected = List.generate(12, (_) => false);
    currentFloor = "空";
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
    currentFloor="空";
    afterFloorFilter = taskDetailList;
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
    notifyListeners();
  }

  //更改选中区域
  void changeAreaSelected(int index, bool value) {
    areaSelected[index] = value; //更新当前的区域选择数据
    afterAreaFilter = afterFloorFilter.where((item) {
      var thisArea = int.parse(item.taskArea);
      return areaSelected[thisArea] & areaEnable[thisArea];
    }).toList();
    notifyListeners();
  }

  //应用当前的筛选条件
  void applyFilter() {
    //如果当前有区域是激活的，但是一个都没选择，那么确认时就默认选全部
    if (areaEnable.any((item) => item) && areaSelected.every((item) => !item)) {
      afterAreaFilter = taskDetailList;
    }
    list2show = afterTypeFilter
        .toSet()
        .intersection(afterFloorFilter.toSet())
        .intersection(afterAreaFilter.toSet())
        .toList();
    notifyListeners();
  }

  //重置所有条件
  void resetFilter() {
    currentShowTaskStatus = null;
    afterAreaFilter = taskDetailList;
    afterFloorFilter = taskDetailList;
    afterTypeFilter = taskDetailList;
    areaSelected = List.generate(12, (_) => false);
    currentFloor = "空";
    notifyListeners();
  }
}
