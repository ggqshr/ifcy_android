import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

///@author ggq
///@description:
///@date :2019/8/27 10:49

class TaskListDataProvider {
  Future<PlanTaskListPageModel> getTask({int listRow = 10, int page = 1}) async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/patrol/tasks",
        queryParameters: {"page": page, "list_rows": listRow});
    return PlanTaskListPageModel.fromJson(res.data['data']);
  }
}

class TaskListRepositories {
  final TaskListDataProvider dataProvider;

  TaskListRepositories({provider})
      : dataProvider = provider ?? TaskListDataProvider();

  Future<PlanTaskListPageModel> getFirstPage() async {
    return await dataProvider.getTask()
      ..currentPageNum = 1;
  }

  Future<PlanTaskListPageModel> getNextPage(int pageNum) async {
    PlanTaskListPageModel model = await dataProvider.getTask(page: pageNum);
    return model;
  }
}
