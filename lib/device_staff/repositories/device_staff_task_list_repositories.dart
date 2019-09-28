import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';

///@author ggq
///@description:
///@date :2019/8/28 21:01
class DeviceStaffTaskListDataProvider {
  final Dio _dio;

  DeviceStaffTaskListDataProvider([dio])
      : _dio = dio ?? DioUtils.getInstance().getDio();

  Future<InspectionTaskPageModel> getTaskList(
      {int listRow = 10, int page, String taskStatus}) async {
    Response res = await _dio.get("/patrol/user/tasks/search",
        queryParameters: {
          "page": page,
          "list_rows": listRow,
          "taskStatus": taskStatus
        });
    return InspectionTaskPageModel.fromJson(res.data['data']);
  }

  Future<InspectionTaskPageModel> getCompleteTask(
      {int listRow=10, int page = 1}) async {
    InspectionTaskPageModel completeModel = await getTaskList(
        taskStatus:
            "${taskStatusToString[TaskStatus.completed]},${taskStatusToString[TaskStatus.out_time_completed]}",
        page: page);
    return completeModel;
  }

  Future<InspectionTaskPageModel> getUnCompleteTask(
      {int listRow=10, int page = 1}) async {
    InspectionTaskPageModel unCompleteModel = await getTaskList(
        page: page,
        taskStatus:
            "${taskStatusToString[TaskStatus.running]},${taskStatusToString[TaskStatus.unreached]},${taskStatusToString[TaskStatus.uncompleted]}");
    return unCompleteModel;
  }
}

class DeviceStaffTaskListRepositories {
  DeviceStaffTaskListDataProvider dataProvider;

  DeviceStaffTaskListRepositories([dataProvider])
      : dataProvider = dataProvider ?? DeviceStaffTaskListDataProvider();

  Future<InspectionTaskPageModel> getFirstPageComplete() async {
    InspectionTaskPageModel completeModel =
        await dataProvider.getCompleteTask()..currentPageNum = 1;
    return completeModel;
  }

  Future<InspectionTaskPageModel> getFirstPageUnComplete() async {
    InspectionTaskPageModel unCompleteModel =
        await dataProvider.getUnCompleteTask()..currentPageNum = 1;
    return unCompleteModel;
  }

  Future<InspectionTaskPageModel> getNextPageComplete(int pageNum) async {
    InspectionTaskPageModel completeModel =
        await dataProvider.getCompleteTask(page: pageNum);
    return completeModel;
  }

  Future<InspectionTaskPageModel> getNextPageUnComplete(int pageNum) async {
    InspectionTaskPageModel unCompleteModel =
        await dataProvider.getUnCompleteTask(page: pageNum);
    return unCompleteModel;
  }
}
