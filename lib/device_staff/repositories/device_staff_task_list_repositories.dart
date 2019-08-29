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
      {int listRow = 1, int page = 1, String taskStatus}) async {
    Response res = await _dio.get("/patrol/user/tasks/search",
        queryParameters: {
          "page": page,
          "list_rows": listRow,
          "taskStatus": taskStatus
        });
    return InspectionTaskPageModel.fromJson(res.data['data']);
  }
}

class DeviceStaffTaskListRepositories {
  DeviceStaffTaskListDataProvider dataProvider;

  DeviceStaffTaskListRepositories([dataProvider])
      : dataProvider = dataProvider ?? DeviceStaffTaskListDataProvider();

  Future<InspectionTaskPageModel> getFirstPageComplete() async {
    InspectionTaskPageModel completeModel = await dataProvider.getTaskList(
        taskStatus: taskStatusToString[TaskStatus.completed]);
    InspectionTaskPageModel unCompleteModel = await dataProvider.getTaskList(
        taskStatus: taskStatusToString[TaskStatus.uncompleted]);
    InspectionTaskPageModel outTimeCompleteModel =
        await dataProvider.getTaskList(
            taskStatus: taskStatusToString[TaskStatus.out_time_completed]);

    return unCompleteModel.copy(completeModel).copy(outTimeCompleteModel)
      ..currentPageNum = 1;
  }

  Future<InspectionTaskPageModel> getFirstPageUnComplete() async {
    InspectionTaskPageModel runningModel = await dataProvider.getTaskList(
        taskStatus: taskStatusToString[TaskStatus.running]);
    InspectionTaskPageModel unReachModel = await dataProvider.getTaskList(
        taskStatus: taskStatusToString[TaskStatus.unreached]);
    return unReachModel.copy(runningModel)..currentPageNum = 1;
  }

  Future<InspectionTaskPageModel> getNextPageComplete(int pageNum) async {
    InspectionTaskPageModel completeModel = await dataProvider.getTaskList(
      taskStatus: taskStatusToString[TaskStatus.completed],
      page: pageNum,
    );
    InspectionTaskPageModel unCompleteModel = await dataProvider.getTaskList(
      taskStatus: taskStatusToString[TaskStatus.uncompleted],
      page: pageNum,
    );
    InspectionTaskPageModel outTimeCompleteModel =
        await dataProvider.getTaskList(
      taskStatus: taskStatusToString[TaskStatus.out_time_completed],
      page: pageNum,
    );
    return unCompleteModel.copy(completeModel).copy(outTimeCompleteModel);
  }

  Future<InspectionTaskPageModel> getNextPageUnComplete(int pageNum) async {
    InspectionTaskPageModel runningModel = await dataProvider.getTaskList(
      taskStatus: taskStatusToString[TaskStatus.running],
      page: pageNum,
    );
    InspectionTaskPageModel unReachModel = await dataProvider.getTaskList(
      taskStatus: taskStatusToString[TaskStatus.unreached],
      page: pageNum,
    );
    return unReachModel.copy(runningModel);
  }
}
